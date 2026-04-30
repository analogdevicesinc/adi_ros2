#!/bin/bash

# ADI ROS2 sources all package directories
OVERLAY="${OVERLAY:-/opt/ros/adi_ros2}"

# Source the base ROS distribution
if [ -z "$AMENT_PREFIX_PATH" ]; then
    source "/opt/ros/${ROS_DISTRO}/setup.bash" --
fi

# Source all local_setup.bash files from package directories
shopt -s nullglob
for setup_file in "${OVERLAY}"/*/share/*/local_setup.bash; do
    [ -f "$setup_file" ] && source "$setup_file" --
done
