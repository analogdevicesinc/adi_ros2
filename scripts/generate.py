#!/usr/bin/env python3
"""Generate the dockerfiles from a jinja template."""
import ruamel.yaml
import json
import logging
from jinja2 import Environment, FileSystemLoader
import os
import subprocess


log = logging.getLogger(__name__)
json_parser = json
yaml = ruamel.yaml.YAML()
yaml.preserve_quotes = True

# Run in the root of the repository
base_dir = subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip()
os.chdir(base_dir)


class Templates:
    """Accessor to the templates file."""

    def __init__(self):
        """Initialize with a cache the templates.yml file."""
        self._settings = None
        with open("scripts/templates.yml", "r") as file:
            self._settings = yaml.load(file)

    def raw(self) -> dict:
        """Get raw template settings.

        Returns:
            dict: template settings
        """
        return self._settings

    def dockerfile_settings(self, eol: bool = False) -> dict:
        """Get dockerfile generation settings.

        Args:
            eol (bool, optional): Include eol images. Defaults to False.

        Returns:
            dict: Repository generation settings
        """
        dockerfiles = []
        for repository in self._settings:
            for settings in self._settings[repository]:
                if not eol and "eol" in settings:
                    continue
                name = settings["name"]
                settings["template_file"] = f"{repository}.dockerfile.jinja"
                settings["out_file"] = f"docker/{repository}/{name}.Dockerfile"
                dockerfiles.append(settings)
        return dockerfiles

    def dockercompose_settings(self, eol: bool = False) -> dict:
        """Get docker compose generation settings.

        Args:
            eol (bool, optional): Include eol images. Defaults to False.

        Returns:
            dict: Repository generation settings
        """
        docker_compose_files = []
        # Currently only gz has compose files
        repository = "gz"
        for distro in self._settings[repository]:
            if "eol" in distro and not eol:
                continue
            # # TODO: Update to allow nvidia/cuda
            # if "nvidia" in distro["base_image"]:
            #     continue
            name = distro["name"]
            distro["compose_file"] = f"{repository}.docker-compose.yml.jinja"
            distro["compose_out_file"] = \
                f"docker-compose/{repository}/{name}-docker-compose.yml"
            docker_compose_files.append(distro)
        return docker_compose_files

    def images(self, eol: bool = False) -> dict:
        """Get dict of images and targets to build.

        Args:
            eol (bool, optional): Include eol images. Defaults to False.

        Returns:
            dict: images and targets
        """
        image_list = {}
        for repository in self._settings:
            for dockerfile in self._settings[repository]:
                if not eol and "eol" in dockerfile:
                    continue
                targets = list()
                for target in dockerfile["targets"]:
                    targets.append(target["target"])
                platforms = list()
                for target in dockerfile["targets"]:
                    platforms.append(target["platforms"])
                image_list[dockerfile["name"]] = {
                    "repository": repository,
                    "targets": targets,
                    "platforms": platforms,
                }
        return image_list

    def workflow_names(self, eol: bool = False) -> list:
        """List workflow docker images.

        Args:
            eol (bool, optional): Include eol images. Defaults to False.

        Returns:
            list: A list includes for github workflow
        """
        data = self._settings
        output = []

        for repo in data:
            for entry in data[repo]:
                tag = entry["name"]
                if not eol and "eol" in entry.keys():
                    continue

                for target in entry["targets"]:
                    item = {
                        "label": repo,
                        "tag": tag,
                        "target": target["target"],
                        "platforms": target["platforms"],
                    }
                    output.append(item)
        return output

    def task_names(self, eol: bool = False) -> list:
        """List workflow docker images.

        Args:
            eol (bool, optional): Include eol images. Defaults to False.

        Returns:
            list: A list of image names
        """
        image_list = []
        for repository in self._settings:
            for dockerfile in self._settings[repository]:
                if not eol and "eol" in dockerfile.keys():
                    continue
                image_list.append(dockerfile["name"])
        return image_list

    def repo_names(self) -> list:
        """List the docker repos.

        Returns:
            list: The docker repository names
        """
        return [repository for repository in self._settings]

    def supported_architectures(self) -> list:
        """Get list of supported architectures from all configurations.

        Returns:
            list: Unique list of supported architectures
        """
        architectures = set()
        for repo in self._settings.values():
            for config in repo:
                if 'arch' in config:
                    architectures.add(config['arch'])
        return sorted(list(architectures))


templates = Templates()


def generate_dockerfiles(log):
    """Generate the dockerfiles for this repo."""
    file_loader = FileSystemLoader("template")
    env = Environment(loader=file_loader)

    for dockerfile in templates.dockerfile_settings():
        # The jinja template
        template = env.get_template(dockerfile["template_file"])
        output = template.render(dockerfile)
        out_file = dockerfile["out_file"]

        out_dir, _ = out_file.rsplit("/", 1)
        os.makedirs(out_dir, exist_ok=True)

        log.info(f"Generating {out_file}")
        dockerfile_out = open(out_file, "w")
        dockerfile_out.write(output)
        dockerfile_out.close()


def generate_readmes(log):
    """Generate the readme files."""
    file_loader = FileSystemLoader("template")
    env = Environment(loader=file_loader)
    repositories = templates.repo_names()
    for repository in repositories:
        dockerfiles = templates.raw()[repository]
        log.info("Generating readme for {}".format(repository))
        readme_template = env.get_template("readme.md.jinja")
        readme_output = readme_template.render(
            {"repo_name": repository, "dockerfiles": dockerfiles}
        )
        readme_file = f"{repository}/README.md"
        readme_out = open(readme_file, "w")
        readme_out.write(readme_output)
        readme_out.close()


def generate_docker_workflow(log):
    """Generate workflow with non-eol images."""
    workflow_file = ".github/workflows/docker.yml"
    log.info(f"Generating workflow file: {workflow_file}")
    docker_workflow = None

    workflows_amd64 = list()
    workflows_arm64 = list()
    for template in templates.workflow_names():
        log.debug(f"Processing template: {template['label']} {template['tag']}")
        if "amd64" in str(template["platforms"]):
            workflows_amd64.append(template)
        if "arm64" in str(template["platforms"]) or "l4t" in str(template["platforms"]):
            workflows_arm64.append(template)

    with open(workflow_file, 'r') as file:
        docker_workflow = yaml.load(file)
        docker_workflow["jobs"]["docker-amd64"]["strategy"]["matrix"] = {
            "include": workflows_amd64}
        docker_workflow["jobs"]["docker-arm64"]["strategy"]["matrix"] = {
            "include": workflows_arm64}

    with open(workflow_file, "w") as file:
        yaml.indent(mapping=2, sequence=4, offset=2)
        yaml.width = 4294967296  # A very large number
        yaml.dump(docker_workflow, file)


def generate_action_docker_readme(log):
    """Generate docker readme file workflow."""
    workflow_file = ".github/workflows/docker_readme.yml"
    docker_workflow = None
    with open(workflow_file, "r") as file:
        docker_workflow = yaml.load(file)
        docker_workflow["jobs"]["readme"]["strategy"]["matrix"] = {
            "docker_repo": templates.repo_names()
        }

    with open(workflow_file, "w") as file:
        yaml.indent(mapping=2, sequence=4, offset=2)
        yaml.dump(docker_workflow, file)


def generate_docker_main_readme(log):
    """Generate the main Docker README with image information."""
    file_loader = FileSystemLoader("template")
    env = Environment(loader=file_loader)

    # Get the current branch name for GitHub links
    try:
        branch_sha = subprocess.check_output(
            ["git", "rev-parse", "HEAD"],
            text=True
        ).strip()
    except subprocess.CalledProcessError:
        branch_sha = "humble"  # fallback

    # Prepare data for template
    template_data = {
        'repositories': templates.raw(),
        'supported_architectures': templates.supported_architectures(),
        'branch_sha': branch_sha
    }

    log.info("Generating Docker README with dynamic content")
    readme_template = env.get_template("docker_readme.md.jinja")
    readme_output = readme_template.render(template_data)

    readme_file = "docker/README.md"
    with open(readme_file, "w") as readme_out:
        readme_out.write(readme_output)

    log.info(f"Generated {readme_file}")

    log.info("Generating github action docker readme workflow")
    generate_action_docker_readme(log)


if __name__ == "__main__":
    # Set up logger.
    log.setLevel(logging.INFO)
    formatter = logging.Formatter("%(message)s")
    stream_handler = logging.StreamHandler()
    stream_handler.setLevel(logging.INFO)
    stream_handler.setFormatter(formatter)
    log.addHandler(stream_handler)

    log.info("\n" + "="*80)
    log.info("Generating dockerfiles ...")
    generate_dockerfiles(log)
    log.info("="*80)

    log.info("\n" + "="*80)
    log.info("Updating CI workflow ...")
    generate_docker_workflow(log)
    log.info("="*80)

    log.info("\n" + "="*80)
    log.info("Generating Docker README ...")
    generate_docker_main_readme(log)
    log.info("="*80)