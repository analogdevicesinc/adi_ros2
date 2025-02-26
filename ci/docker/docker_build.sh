#!/usr/bin/env bash

# set -ex

# ==============================================================================
usage() {
    cat <<EOF
Usage: $0

This script builds Docker images for specified ROS distributions.
You need to define an environment variable called ROS_DISTROS with a list of ROS distributions.

Example:
export ROS_DISTROS=humble
$0

Options:
-h, --help    Show this help message and exit
EOF
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi
# ==============================================================================
ROS_DISTROS=(${ROS_DISTROS:-unset})
BASE_REPO_DIR=$(git rev-parse --show-toplevel)

if [ "${ROS_BISTROS}" == "unset" ]; then
    echo "ROS_DISTROS is not set. Exiting..."
    exit 1
fi

cd "$BASE_REPO_DIR" || exit

echo "Starting build for ROS_DISTRO: ${ROS_DISTRO} ..."

docker build \
    --no-cache \
    --file ./ci/docker/Dockerfile \
    --build-arg ROS_DISTRO=${ROS_DISTRO} \
    --tag adi_ros2:${ROS_DISTRO}-dev .

echo "Finished build for ROS_DISTRO: ${ROS_DISTRO}"

echo "All builds completed"
