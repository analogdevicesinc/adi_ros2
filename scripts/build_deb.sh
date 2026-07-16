#!/usr/bin/env bash
#===============================================================================
# Build a Debian (.deb) package for a ROS2 package.
#
# Usage:
#   ./scripts/build_deb.sh
#
# Environment variables (all optional):
#   ROS_DISTRO   ROS2 distribution to build for   (default: jazzy)
#   OS_NAME      Target OS for bloom               (default: ubuntu)
#   OS_VERSION   Target OS codename for bloom      (default: noble)
#   OUTPUT_DIR   Directory to collect artifacts in (default: <pkg>/../deb_output)
#   SKIP_ROSDEP  If set to 1, skip rosdep install  (default: unset)
#
# Requirements:
#   python3-bloom python3-rosdep fakeroot debhelper dpkg-dev
#   A matching ROS2 environment under /opt/ros/${ROS_DISTRO}
#===============================================================================
set -euo pipefail

ROS_DISTRO="${ROS_DISTRO:-jazzy}"

# Utilities needed to build the .deb package
required_tools=(
    python3-bloom
    python3-rosdep
    fakeroot
    debhelper
    dpkg-dev
)
sudo apt update
sudo apt install -y "${required_tools[@]}"

# Resolve the package root (parent of this scripts/ directory).
package_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="${OUTPUT_DIR:-${package_dir}/../deb_output}"

cd "${package_dir}"

if [ ! -f package.xml ]; then
    echo "ERROR: package.xml not found in ${package_dir}" >&2
    exit 1
fi

echo ">> Building .deb for package in ${package_dir}"
echo ">>   ROS_DISTRO=${ROS_DISTRO}"

if [ -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]; then
    # ROS setup scripts may read unset tracing variables and are not nounset-safe.
    set +u
    . "/opt/ros/${ROS_DISTRO}/setup.bash"
    set -u
fi

if [ "${SKIP_ROSDEP:-0}" != "1" ]; then
    echo ">> Resolving dependencies with rosdep"
    rosdep update --rosdistro "${ROS_DISTRO}" || true
    rosdep install --from-paths . --ignore-src -y \
        --rosdistro "${ROS_DISTRO}"
fi

echo ">> Cleaning previous packaging artifacts"
rm -rf debian .obj-*

echo ">> Generating debian/ with bloom-generate"
bloom-generate rosdebian

echo ">> Building the .deb (fakeroot debian/rules binary)"
fakeroot debian/rules binary

# 4. Collect the artifacts into OUTPUT_DIR.
mkdir -p "${OUTPUT_DIR}"
shopt -s nullglob
artifacts=( "${package_dir}"/../ros-"${ROS_DISTRO}"-*.deb \
            "${package_dir}"/../ros-"${ROS_DISTRO}"-*.ddeb )
if [ ${#artifacts[@]} -eq 0 ]; then
    echo "ERROR: no .deb artifacts were produced" >&2
    exit 1
fi
mv -v "${artifacts[@]}" "${OUTPUT_DIR}/"

echo ">> Done. Artifacts in ${OUTPUT_DIR}:"
ls -1 "${OUTPUT_DIR}"
