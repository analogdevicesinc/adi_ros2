#!/bin/bash
set -e

# Source the ROS2 setup file
source /opt/ros/${ROS_DISTRO}/setup.sh

# Source the workspace setup file
source ${OVERLAY_WS}/install/setup.sh

# Execute the provided command or start a bash shell
exec "$@"
