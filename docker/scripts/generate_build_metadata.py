#!/usr/bin/env python3
"""Generate the ADI Robotics SDK welcome banner and version metadata.


Usage:
    python3 generate_build_metadata.py <overlay_dir> <ros_distro> <sdk_version> [workspace_dir]
"""

import logging
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Optional


# Configure logging
logging.basicConfig(
    format="%(levelname)s: %(message)s",
    level=logging.DEBUG,
    stream=sys.stderr,
)
logger = logging.getLogger(__name__)

# Packages that are infrastructure/meta — not shown in the banner
_SKIP = {"adi_meta", "adi_ros2_demos"}


def parse_vcs_manifest(manifest_path: Path) -> dict[str, str]:
    """Parse VCS manifest YAML file and return repo versions.

    Returns a dict mapping repo paths to version strings (branches/tags/SHAs).
    Uses simple YAML parsing (no external dependencies).

    Handles the standard VCS manifest structure:
        repositories:
          repo_name:
            version: humble
            type: git
            url: ...
    """
    repos = {}

    if not manifest_path.exists():
        logger.warning(f"VCS manifest not found: {manifest_path}")
        return repos

    try:
        current_repo = None
        in_repositories_section = False

        with open(manifest_path) as f:
            for line in f:
                line = line.rstrip()
                if not line or line.startswith("#"):
                    continue

                # Skip the top-level "repositories:" key
                if line == "repositories:":
                    in_repositories_section = True
                    current_repo = None
                    continue

                # Top-level key (anything not indented after "repositories:" ends the section)
                if line and not line.startswith(" "):
                    in_repositories_section = False
                    current_repo = None
                    continue

                # Only process if we're in the repositories section
                if not in_repositories_section:
                    continue

                # Count leading spaces to determine nesting level
                stripped = line.lstrip()
                indent = len(line) - len(stripped)

                if indent == 2:
                    # Repo name level (two spaces)
                    current_repo = stripped.rstrip(":")
                elif indent == 4 and current_repo:
                    # Property level (four spaces)
                    if ":" in stripped:
                        key, value = stripped.split(":", 1)
                        key = key.strip()
                        value = value.strip()

                        if key == "version":
                            repos[current_repo] = value

        logger.debug(f"Parsed {len(repos)} repositories from VCS manifest")
        logger.debug(f"Repository versions: {repos}")
        return repos
    except Exception as e:
        logger.error(f"Failed to parse VCS manifest: {e}")
        return {}


def get_git_sha(repo_path: Path) -> Optional[str]:
    """Get the current commit SHA of a git repository.

    Uses 'git rev-parse HEAD' to get the actual checked-out commit.
    Returns the short SHA (7 chars) or None if extraction fails.
    """
    if not (repo_path / ".git").exists():
        return None

    try:
        result = subprocess.run(
            ["git", "rev-parse", "--short=7", "HEAD"],
            cwd=str(repo_path),
            capture_output=True,
            text=True,
            timeout=5,
        )
        if result.returncode == 0:
            return result.stdout.strip()
    except (subprocess.TimeoutExpired, FileNotFoundError) as e:
        logger.debug(f"Failed to get SHA for {repo_path}: {e}")

    return None


def get_package_name_from_repo(repo_path: Path) -> Optional[str]:
    """Extract the ROS package name from a repository's package.xml file.

    Searches for package.xml in the repository root or subdirectories.
    Returns the package name or None if not found.

    Note: For repos with multiple packages, returns only the first one found.
    Use get_all_package_names_from_repo() to get all packages.
    """
    try:
        # Look for package.xml in repo root
        pkg_xml = repo_path / "package.xml"
        if pkg_xml.exists():
            root = ET.parse(pkg_xml).getroot()
            name = root.findtext("name", default="").strip()
            if name:
                return name

        # If not in root, search subdirectories (one level deep)
        for subdir_pkg_xml in repo_path.glob("*/package.xml"):
            root = ET.parse(subdir_pkg_xml).getroot()
            name = root.findtext("name", default="").strip()
            if name:
                return name
    except Exception as e:
        logger.debug(f"Failed to extract package name from {repo_path}: {e}")

    return None


def get_all_package_names_from_repo(repo_path: Path) -> list[str]:
    """Extract ALL ROS package names from a repository.

    Searches for package.xml in the repository root and subdirectories (one level deep).
    Returns a list of all package names found, or empty list if none found.

    This handles multi-package repositories like adi_tmc_coe_ros2 which contains:
    - adi_tmc_coe
    - adi_tmc_coe_core
    - adi_tmc_coe_interfaces
    """
    packages = []
    try:
        # Look for package.xml in repo root
        pkg_xml = repo_path / "package.xml"
        if pkg_xml.exists():
            root = ET.parse(pkg_xml).getroot()
            name = root.findtext("name", default="").strip()
            if name:
                packages.append(name)

        # Search subdirectories (one level deep) for additional packages
        for subdir_pkg_xml in sorted(repo_path.glob("*/package.xml")):
            root = ET.parse(subdir_pkg_xml).getroot()
            name = root.findtext("name", default="").strip()
            if name and name not in packages:  # Avoid duplicates
                packages.append(name)
    except Exception as e:
        logger.debug(f"Failed to extract package names from {repo_path}: {e}")

    return packages


def collect_git_info(workspace_dir: Path, manifest_repos: dict[str, str]) -> dict[str, str]:
    """Extract git SHAs from the workspace source repositories.

    For each repository in the manifest, attempts to get the actual checked-out
    commit SHA from the workspace AND extract ALL actual package names from package.xml files.
    Falls back to the manifest version string if the SHA cannot be determined.

    Handles multi-package repositories (e.g., adi_tmc_coe_ros2 contains 3 packages).
    All packages from the same repo get the same git SHA since they share the same commit.

    Returns a dict mapping actual package names to git SHAs/versions.
    """
    git_info = {}

    logger.debug(f"collect_git_info: checking {len(manifest_repos)} repos from manifest")

    for repo_path_str, manifest_version in manifest_repos.items():
        # repo_path_str is like "iio_ros2" or "algorithms/adi_3dtof_floor_detector"
        repo_path = workspace_dir / "src" / repo_path_str

        # Extract ALL package names from this repository
        # This handles multi-package repos like adi_tmc_coe_ros2
        package_names = get_all_package_names_from_repo(repo_path)

        if not package_names:
            # Fallback: use last component of repo path
            package_names = [repo_path_str.split("/")[-1]]
            logger.debug(f"{repo_path_str}: no package.xml found, using repo name {package_names[0]}")
        elif len(package_names) > 1:
            logger.debug(f"{repo_path_str}: found {len(package_names)} packages: {package_names}")

        # Try to get actual SHA from workspace (same SHA for all packages in the repo)
        sha = get_git_sha(repo_path)
        if sha:
            version = sha
            logger.debug(f"{repo_path_str}: resolved to SHA {sha}")
        else:
            # Use manifest version as fallback (same for all packages in the repo)
            version = manifest_version
            logger.debug(f"{repo_path_str}: using manifest version {manifest_version}")

        # Assign the same SHA/version to all packages from this repository
        for package_name in package_names:
            git_info[package_name] = version

    logger.info(f"Extracted git info for {len(git_info)} packages from {len(manifest_repos)} repositories")
    return git_info


def collect_packages(overlay_dir: Path) -> list[tuple[str, str]]:
    """Scan overlay for installed packages and extract name/version from package.xml.

    Returns a sorted list of (package_name, version) tuples.
    """
    packages = []
    seen = set()

    for pkg_xml in sorted(overlay_dir.rglob("package.xml")):
        try:
            root = ET.parse(pkg_xml).getroot()
            name = root.findtext("name", default="").strip()
            version = root.findtext("version", default="N/A").strip()

            if name and name not in _SKIP and name not in seen:
                seen.add(name)
                packages.append((name, version))
        except ET.ParseError as e:
            logger.warning(f"Failed to parse {pkg_xml}: {e}")

    logger.info(f"Found {len(packages)} packages in overlay")
    return packages


def generate_versions_file(
    overlay_dir: Path,
    ros_distro: str,
    sdk_version: str,
    packages: list[tuple[str, str]],
    git_info: dict[str, str],
) -> None:
    """Write detailed versions.txt file with package and git information."""
    versions_file = overlay_dir / "versions.txt"

    lines = [
        "ADI Robotics SDK - Build Information",
        "=" * 80,
        "",
        f"SDK Version:        {sdk_version}",
        f"ROS 2 Distro:       {ros_distro}",
        f"Overlay Location:   {overlay_dir}",
        f"VCS Manifest:       {overlay_dir}/adi_ros2-{ros_distro}.yml",
        "",
        "Bundled Packages with Git Version Information:",
        "=" * 80,
        f"{'Package Name':<36}{'Version':<16}{'Git SHA/Version':<28}",
        "-" * 80,
    ]

    for name, version in packages:
        git_version = git_info.get(name, "N/A")
        lines.append(f"{name:<36}{version:<16}{git_version:<28}")

    lines += [
        "-" * 80,
        "",
        "Git Information:",
        "  The 'Git SHA/Version' column shows the actual checked-out commit,",
        "  extracted from the source workspace during the build.",
        "",
    ]

    try:
        versions_file.write_text("\n".join(lines))
        logger.info(f"Generated versions.txt at {versions_file}")
    except Exception as e:
        logger.error(f"Failed to write versions.txt: {e}")
        raise


def generate_welcome_banner(
    ros_distro: str,
    sdk_version: str,
    overlay_dir: Path,
    packages: list[tuple[str, str]],
) -> str:
    """Generate the welcome banner text displayed in interactive shells."""
    width = 66
    bar = "─" * width

    lines = [
        "",
        bar,
        f"  ADI Robotics SDK  ·  ROS2 {ros_distro.capitalize()}  ·  v{sdk_version}",
        bar,
        "",
        "  Bundled ADI packages:",
    ]

    if packages:
        max_name = max(len(name) for name, _ in packages)
        name_col = max(max_name + 2, 36)
        ver_col = 16

        lines.append(f"    {'Package':<{name_col}}{'Version':<{ver_col}}")
        lines.append(f"    {'─' * name_col}{'─' * ver_col}")

        for name, version in packages:
            lines.append(f"    {name:<{name_col}}{version:<{ver_col}}")

    lines += [
        "",
        f"  Overlay:  {overlay_dir}",
        f"  Manifest: {overlay_dir}/adi_ros2-{ros_distro}.yml",
        f"  Versions: {overlay_dir}/versions.txt",
        "  Docs:     https://analogdevicesinc.github.io/adi_ros2/",
        "  Issues:   https://github.com/analogdevicesinc/adi_ros2/issues",
        "",
        bar,
        "",
    ]

    return "\n".join(lines)


def main() -> None:
    if len(sys.argv) < 4:
        print(
            f"Usage: {sys.argv[0]} <overlay_dir> <ros_distro> <sdk_version> [workspace_dir]",
            file=sys.stderr,
        )
        sys.exit(1)

    overlay_dir = Path(sys.argv[1])
    ros_distro = sys.argv[2]
    sdk_version = sys.argv[3]
    workspace_dir = Path(sys.argv[4]) if len(sys.argv) > 4 else Path("/adi_ros2_ws")

    logger.info(f"Generating welcome banner for ROS {ros_distro} v{sdk_version}")
    logger.debug(f"Overlay: {overlay_dir}, Workspace: {workspace_dir}")

    # Collect packages from installed overlay
    packages = collect_packages(overlay_dir)

    # Load VCS manifest and extract git information
    manifest_file = overlay_dir / f"adi_ros2-{ros_distro}.yml"
    manifest_repos = parse_vcs_manifest(manifest_file)
    logger.debug(f"Manifest repos: {list(manifest_repos.keys())}")

    # Extract actual git SHAs from workspace if available
    git_info = {}
    if workspace_dir.exists():
        git_info = collect_git_info(workspace_dir, manifest_repos)
    else:
        logger.warning(f"Workspace directory not found: {workspace_dir}")
        git_info = {repo.split("/")[-1]: v for repo, v in manifest_repos.items()}

    # Generate versions file
    generate_versions_file(overlay_dir, ros_distro, sdk_version, packages, git_info)

    # Print welcome banner to stdout (captured to /etc/adi_ros2_welcome)
    banner = generate_welcome_banner(ros_distro, sdk_version, overlay_dir, packages)
    print(banner)

    logger.info("Welcome banner generated successfully")


if __name__ == "__main__":
    main()
