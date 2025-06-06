#!/bin/bash
set -e

# Setup ros2 environment
if [ -f /opt/ros/$ROS_DISTRO/setup.bash ]; then
    source "/opt/ros/$ROS_DISTRO/setup.bash" --
fi

# Setup ADI ROS2 environment
if [ -f /opt/ros/adi_ros2/setup.bash ]; then
    source "/opt/ros/adi_ros2/setup.bash" --
fi

exec "$@"
