<!--
********************************************************************************
    WARNING: DO NOT EDIT "docker/README.md"; IT IS AUTO-GENERATED

    Instead:

    1. Edit the Jinja2 template at "template/docker_readme.md.jinja" instead.

    2. Run the script to regenerate this file:
    --ipc=host \
        `python scripts/generate_docker_readme.py`
********************************************************************************
-->

# Quick Reference

-	**Maintained by**:
	[Analog Devices Inc](https://github.com/analogdevicesinc/adi_ros2)

-	**Where to get help**:
	[Github Issues](https://github.com/analogdevicesinc/adi_ros2/issues)

-   **Docker Hub Links**:
    - [astanea/adi_ros2](https://hub.docker.com/repository/docker/astanea/adi_ros2/general), 
    - [astanea/adi_ros2-l4t](https://hub.docker.com/repository/docker/astanea/adi_ros2-l4t/general)

-   **Supported architectures:**
    `amd64`, 
    `arm64`


# Supported Image Tags and Associated `Dockerfile` Links:

- [`humble-amd64:base`, `humble-amd64:full`, `humble-amd64:desktop`](https://github.com/analogdevicesinc/adi_ros2/blob/ac5b88e437fd901a1639de0abe911e817afd010b/docker/adi_ros2/humble-amd64.Dockerfile)
    - Arch: `amd64`
    - ROS Distro: `humble`
    - Base Image: `ros:humble-ros-base`
    - Libiio: `libiio-v0`

- [`humble-arm64:base`, `humble-arm64:full`, `humble-arm64:desktop`](https://github.com/analogdevicesinc/adi_ros2/blob/ac5b88e437fd901a1639de0abe911e817afd010b/docker/adi_ros2/humble-arm64.Dockerfile)
    - Arch: `arm64`
    - ROS Distro: `humble`
    - Base Image: `ros:humble-ros-base`
    - Libiio: `libiio-v0`

- [`humble-l4t_r36.2.0:base`, `humble-l4t_r36.2.0:full`, `humble-l4t_r36.2.0:desktop`](https://github.com/analogdevicesinc/adi_ros2/blob/ac5b88e437fd901a1639de0abe911e817afd010b/docker/adi_ros2-l4t/humble-l4t_r36.2.0.Dockerfile)
    - Arch: `arm64`
    - ROS Distro: `humble`
    - Base Image: `nvcr.io/nvidia/l4t-base:r36.2.0`
    - Jetson Linux version: `r36.2.0`
    - Libiio: `libiio-v0`


# How to use

## 1. Pull the Docker Image

To use these Docker images, you can pull them from Docker Hub to ensure you
have the latest version.

```bash
sudo docker pull astanea/adi_ros2:humble-amd64-desktop
```

## 2. Run the Container

To run the container:

1. Allow external applications to connect to the host's display (**for GUI applications**):

```bash
xhost +
```

2. Run the Docker container with the necessary options:

```bash
sudo docker run \
        -it --rm \
        --net=host \
        --ipc=host \
        --privileged \
        --env="DISPLAY" \
    astanea/adi_ros2:humble-amd64-desktop
```

Arguments:
- `-it`: Run the container in interactive mode with a TTY.
- `--rm`: Automatically remove the container when it exits.
- `--net=host`: Use the host's network stack.
- `--ipc=host`: Share the host's IPC namespace, useful for inter-process communication.
- `--privileged`: Grant extended privileges to the container for hardware access.


# Image Tag Naming Convention

Our Docker images follow a structured naming convention to help you identify
the right image for your needs:

## Repository Labels
The repository name indicates the target platform:
- **`adi_ros2`**: Standard Ubuntu-based images for x86_64 and ARM64 architectures
- **`adi_ros2-l4t`**: NVIDIA Jetson-specific images based on L4T (Linux for Tegra)

## Tag Format: `{ros-distro}-{arch/platform}-{stage}`
- **`{ros-distro}`**: ROS2 distribution (e.g., `humble`, `iron`, `jazzy`)
- **`{arch/platform}`**: Target architecture or platform:
  - `amd64`: x86_64 architecture
  - `arm64`: ARM64 architecture
  - `l4t-r{version}`: NVIDIA Jetson L4T version (e.g., `l4t_r36.2.0`)
- **`{stage}`**: Build stage (`base`, `full`, `desktop`)

### Examples:
- `adi_ros2:humble-amd64-full` - ROS2 Humble on x86_64 with full stage
- `adi_ros2:iron-arm64-desktop` - ROS2 Iron on ARM64 with desktop stage
- `adi_ros2_l4t:humble-l4t-r36.2.0-base` - ROS2 Humble on Jetson L4T R36.2.0 with base stage


# Image Stage Definitions

Our Docker images use multi-stage builds where each stage adds more content:

-   **`base`**: Basic ROS2 installation + all ADI ROS2 packages along with their dependencies.

-   **`full`**: Built on `base` + 3rd party tools such as Navigation2, SLAM Toolbox, CANopen, etc.

-   **`desktop`**: Built on `full` + ROS desktop packages to provide development and visualization tools.