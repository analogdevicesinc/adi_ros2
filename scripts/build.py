#!/usr/bin/env python3
"""Update script for dockerfiles."""
import os
import subprocess
import click
import logging
from datetime import date
from generate import templates
from generate import generate_dockerfiles as gen

TODAY = date.today()
USER = os.environ.get("DOCKERHUB_USERNAME", "analog")

log = logging.getLogger(__name__)

# Run in the root of the repository
base_dir = subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip()
os.chdir(base_dir)


class Docker(object):
    """Managed docker class to hide complexity with logging output."""

    def __init__(self):
        """Initialize docker container from environment."""

    def build(self, context, dockerfile, repository, tag, target, labels, platforms):
        """Build the specified container.

        Args:
            context: The path to the context
            dockerfile: The relative path to the dockerfile from the context
            repository: The name of the repository to build
            tag: The tag for the build
            target: The target to build in a multi-stage docker
            labels: Extra label to add to the image
        """
        build_tag = f"{repository}:{tag}"

        log.info(f"Building {context}/{dockerfile} --target {target} as {build_tag}")
        log.info(f"Context: {context}")
        log.info(f"Dockerfile: {dockerfile}")
        log.info(f"Repository: {repository}")
        log.info(f"Tag: {build_tag}")
        log.info(f"Target: {target}")
        log.info(f"Labels: {labels}")
        log.info(f"Platforms: {platforms}")
        ret = os.system(
            f"docker buildx build "
            f"--platform {platforms} "
            f"--file {dockerfile} "
            f"--target {target} "
            f"--progress plain "
            f"--tag {build_tag} "
            f"--pull {context}"
        )
        if ret != 0:
            raise Exception("Error building docker image")
        log.info(f"Done building {build_tag}")

    def tag(self, repository, prev_tag, new_tag):
        """Tag a built image."""
        image = f"{repository}:{prev_tag}"
        log.info(f"Taging {image} --> {repository}:{new_tag}")
        ret = os.system(f"docker tag {image} {repository}:{new_tag}")
        if ret != 0:
            raise Exception("Error tagging docker image")

    def push(self, repository, tag):
        """Push a built repository:tag to a registry.

        Format: repository:tag

        Args:
            repository: The name of the repository.
            tag: The name of the tag.
        """
        log.info(f"Pushing {repository}:{tag}")
        ret = os.system(f"docker push {repository}:{tag}")
        if ret != 0:
            raise Exception("Error pushing docker image")

        log.info(f"Done pushing {repository}:{tag}")

    def prune(self):
        """Prune dangling images."""
        ret = os.system("docker system prune -f")
        if ret != 0:
            raise Exception("Error pruning docker images")

    def rmi(self, repository, tag):
        """Remove image by repository and tag."""
        image = f"{repository}:{tag}"
        ret = os.system(f"docker rmi {image}")
        if ret != 0:
            raise Exception("Error removing docker image")


def build(image, target, push, clean):
    """Build the docker images."""
    builds = templates.images(eol=True)
    if image != "all":
        builds = {image: templates.images()[image]}

    # Build docker images.
    dockerpy = Docker()
    for name in builds:
        folder = builds[name]["repository"]
        repository = f"{USER}/{folder}"
        targets = builds[name]["targets"] if not target else [target]
        context = base_dir
        dockerfile = f"docker/{folder}/{name}.Dockerfile"
        labels = {"version": f"{TODAY}"}
        for target, platforms in zip(targets, builds[name]["platforms"]):
            latest_tag = f"{name}-{target}"
            dated_tag = f"{latest_tag}-{TODAY}"
            dockerpy.build(
                context=context,
                dockerfile=dockerfile,
                repository=repository,
                tag=latest_tag,
                target=target,
                labels=labels,
                platforms=platforms,
            )
            dockerpy.tag(
                repository=repository, prev_tag=latest_tag, new_tag=dated_tag
            )

            if push:
                dockerpy.push(repository=repository, tag=latest_tag)
                dockerpy.push(repository=repository, tag=dated_tag)

    if clean:
        dockerpy.rmi(repository=repository, tag=dated_tag)
        dockerpy.prune()


@click.command()
@click.option(
    "--generate/--no-generate", default=False, help="Generate docker files."
)
@click.option(
    "--push/--no-push",
    default=False,
    help="Push generated images to DockerHub.",
)
@click.option(
    "--clean/--no-clean",
    default=False,
    help="Clean dated content and old images.",
)
@click.option("--target", default="", help="The target to build")
@click.argument("image", type=click.Choice(list(templates.images()) + ["all"]))
def main(generate, push, clean, image, target):
    """Set up logging and trigger build."""
    log.setLevel(logging.DEBUG)
    formatter = logging.Formatter("%(message)s")
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)
    ch.setFormatter(formatter)
    log.addHandler(ch)

    if generate:
        gen(log)

    build(image, target, push, clean)


if __name__ == "__main__":
    # pylint: disable=no-value-for-parameter
    main()
