##############################################
# Created from template l4t.dockerfile.jinja
##############################################
ARG OVERLAY=/opt/ros/adi_ros2
ARG WORKSPACE=/adi_ros2_ws

###########################################
# ROS2 Base Stage
###########################################
FROM nvcr.io/nvidia/l4t-base:r36.2.0 AS ros-base

ENV DEBIAN_FRONTEND=noninteractive

# Setup language
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
  && locale-gen en_US.UTF-8 \
  && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8

# Setup timezone
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    tzdata \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && rm -rf /var/lib/apt/lists/*

# Install common programs
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    dirmngr \
    gnupg2 \
    lsb-release \
    software-properties-common \
    sudo \
    wget \
  && rm -rf /var/lib/apt/lists/*

# Install and Setup ROS2
RUN sudo add-apt-repository universe \
  && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ros-humble-ros-base \
  && rm -rf /var/lib/apt/lists/*

# Setup ROS2 entrypoint script
COPY docker/ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

# Install ROS2 bootstrapping tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    build-essential \
    cmake \
    gdb \
    git \
    openssh-client \
    python3-argcomplete \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-pip \
    python3-rosdep \
    python3-vcstool \
    ros-humble-ament-* \
    ros-dev-tools \
  && rm -rf /var/lib/apt/lists/*

# Setup rosdep
RUN apt-get update && apt-get install -y --no-install-recommends \
  && rosdep init || echo "rosdep already initialized" \
  && rosdep update --rosdistro humble || echo "rosdep already updated" \
  && rm -rf /var/lib/apt/lists/*

# Setup colcon mixin and metadata
RUN colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

ENV DEBIAN_FRONTEND=
ENV ROS_DISTRO=humble

###########################################
# Base stage: ADI ROS2 pacakges
###########################################
FROM ros-base AS base

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
COPY docker/adi_ros2-humble.yml $WORKSPACE/adi_ros2-humble.yml
COPY docker/Makefile $WORKSPACE/Makefile
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
  && apt-get update \
  && make clone \
  && make deps \
  && apt install -y --allow-downgrades libopencv-dev=4.5.4+dfsg-9ubuntu4 \
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

ENV ROS_DISTRO=humble

ENV DEBIAN_FRONTEND=noninteractive
# 3rd party ROS2 packages
RUN apt-get update && apt-get install -y --no-install-recommends\
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-slam-toolbox \
    ros-humble-canopen \
  && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=