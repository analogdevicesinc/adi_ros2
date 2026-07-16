#!/usr/bin/env bash

set -eou pipefail

sudo apt update

if command -v rosdep >/dev/null 2>&1; then
  rosdep update --rosdistro "${ROS_DISTRO}"
fi

if ! colcon mixin list 2>/dev/null | grep -q '^default:'; then
  default_mixin_url="https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml"
  colcon mixin add default "${default_mixin_url}"
fi
colcon mixin update default

cd /adi_ros2_ws
rosdep install --from-paths src --ignore-src -r -y

# adi_imu dependency for RVIZ simulation
sudo apt-get install -y ros-${ROS_DISTRO}-imu-tools

# Automatically source build environment in new shells
echo "[ -f /adi_ros2_ws/install/setup.bash ] && source /adi_ros2_ws/install/setup.bash" >> /etc/bash.bashrc
