#!/usr/bin/env bash

set -euo pipefail

package_name="${1:?Usage: bash scripts/build.sh <package>}"

export MAKEFLAGS="-l1 -j1"

export IIO_ROS2_ENABLE_HW_TESTS=1
export TEST_NODE_NAME="tester"
export TEST_URI="ip:192.168.2.1"
export TEST_TIMEOUT="60"

export IMU_ROS2_ENABLE_HW_TESTS=1

colcon build --event-handlers console_direct+ \
     --packages-up-to "${package_name}" --symlink-install --mixin \
    ccache \
    compile-commands \
    rel-with-deb-info \
    ninja
