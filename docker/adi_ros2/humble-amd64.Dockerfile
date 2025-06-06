##############################################
# Created from template adi_ros2.dockerfile.jinja
##############################################
ARG OVERLAY=/opt/ros/adi_ros2
ARG WORKSPACE=/adi_ros2_ws

###########################################
# Base stage: ADI ROS2 pacakges
###########################################
FROM ros:humble-ros-base AS base

ARG OVERLAY
ARG WORKSPACE

ENV OVERLAY=$OVERLAY
ENV WORKSPACE=$WORKSPACE

ENV DEBIAN_FRONTEND=noninteractive

# Sytem dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    bison \
    build-essential \
    cmake \
    flex \
    git \
    libaio-dev \
    libavahi-client-dev \
    libcdk5-dev \
    libserialport-dev \
    libssl-dev \
    libusb-1.0-0-dev \
    libxml2-dev \
    libzstd-dev \
    tmux \
    vim \
    wget \
  && rm -rf /var/lib/apt/lists/*

# Source builds
WORKDIR /tmp
RUN git clone \
    --depth 1 \
    --branch libiio-v0 \
    https://github.com/analogdevicesinc/libiio.git \
    libiio \
  && cd libiio \
  && mkdir build && cd build \
  && cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DWITH_SYSTEMD=on \
  && cmake --build . --target install \
  && rm -rf /tmp/* \
  && rm -rf /var/lib/apt/lists/*

# Install overlay dependencies
WORKDIR $WORKSPACE
COPY ./docker/adi_ros2-humble.yml $WORKSPACE/adi_ros2-humble.yml
COPY ./docker/Makefile $WORKSPACE/Makefile
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
  && apt-get update \
  && make clone \
  && make deps \
  && rm -rf /var/lib/apt/lists/*

# Build ADI ROS2 packages from source
RUN . /opt/ros/humble/setup.sh \
  && make build-system \
      EXECUTOR=sequential \
      OVERLAY=${OVERLAY} \
  && make clean-build \
  && rm -rf /var/lib/apt/lists/*

RUN if [ -f "${OVERLAY}/setup.bash" ]; then \
  sed --in-place --expression '$isource "$OVERLAY/setup.bash"' /ros_entrypoint.sh; \
  fi

ENV DEBIAN_FRONTEND=

###########################################
#  Full Stage: ADI Robotics SDK
###########################################
FROM base AS full

ENV DEBIAN_FRONTEND=noninteractive
# 3rd party ROS2 packages
RUN apt-get update && apt-get install -y --no-install-recommends\
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-slam-toolbox \
    ros-humble-canopen \
  && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

###########################################
#  Desktop image
###########################################
FROM full AS desktop

ENV DEBIAN_FRONTEND=noninteractive
# Install the desktop release
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
  && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=