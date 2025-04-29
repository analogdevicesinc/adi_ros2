# syntax=docker/dockerfile:1
# Use the script `./ci/docker/build.sh` to build the Docker image.
# Use the ROS2 base image
ARG ROS_DISTRO=humble
ARG FROM_IMAGE=ros:${ROS_DISTRO}-ros-base

FROM ${FROM_IMAGE}

LABEL maintainer="Bogdan Stanea, <Adrian.Stanea@analog.com>"

# Disable apt user dialogs when installing packages
ENV DEBIAN_FRONTEND=noninteractive

ENV OVERLAY_WS=/overlay_ws

# Copy ROS2 source files from meta-repo to the workspace
WORKDIR ${OVERLAY_WS}/src

# Required in adi_imu build process
ENV DEVICE_ID=adis16505-2

COPY src/ ${OVERLAY_WS}/src/
COPY .git ${OVERLAY_WS}/.git

# Copy system dependency installation scripts
WORKDIR /usr/local/bin

COPY ci/*.sh .

# Install system dependencies
RUN chmod +x *.sh \
    && ./install_dependencies.sh install_all \
    && rm -rf /var/lib/apt/lists/*

# Enable apt user dialogs again
ARG DEBIAN_FRONTEND=dialog

WORKDIR $OVERLAY_WS
SHELL ["/bin/bash", "-c"]

# Build the workspace
RUN source /opt/ros/${ROS_DISTRO}/setup.sh \
    && apt-get update \
    && rosdep update \
    && rosdep  install -i --from-path src --rosdistro ${ROS_DISTRO} -y --skip-keys libiio-dev\
    && MAKEFLAGS="-l2" colcon build \
    --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo

# Setup the entrypoint
COPY ci/docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command to run
CMD ["bash"]