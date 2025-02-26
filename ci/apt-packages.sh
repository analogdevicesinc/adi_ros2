#!/usr/bin/env bash

apt_packages=(
    # tof-ros2 deps
    apt-utils
    build-essential
    cmake
    g++-9
    gcc-9
    git
    libgl1-mesa-dev
    libglfw3-dev
    libssl-dev
    wget
    # Build custom .deb pacakge for ROS2
    python3-bloom
    python3-rosdep
    fakeroot
    debhelper
    dh-python
    # libiio
    ## Basic system setup
    build-essential
    libxml2-dev 
    libzstd-dev 
    bison 
    flex 
    libcdk5-dev 
    cmake
    ## Backend deps
    libaio-dev 
    libusb-1.0-0-dev
    libserialport-dev 
    libavahi-client-dev
)