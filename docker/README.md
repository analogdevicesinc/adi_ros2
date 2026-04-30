# ADI ROS2 Docker Images

Full documentation: [analogdevicesinc.github.io/adi_ros2](https://analogdevicesinc.github.io/adi_ros2/)

## Quick Start

```bash
# Build an image
docker compose -f compose.build.yml build base

# Run a container
docker run -it --rm --net=host --ipc=host --privileged adi_ros2:humble-base
```

## Available Stages

| Stage     | Description                        |
| --------- | ---------------------------------- |
| `core`    | ROS2 core + ADI packages (minimal) |
| `base`    | ROS2 base + all ADI packages       |
| `full`    | base + Nav2, SLAM, CANopen         |
| `desktop` | full + RViz2, rqt                  |

## Build Examples

```bash
# Single stage
docker compose -f compose.build.yml build core
docker compose -f compose.build.yml build base
docker compose -f compose.build.yml build full
docker compose -f compose.build.yml build desktop

# All stages
docker compose -f compose.build.yml build

# Jetson/L4T (arm64 host)
docker compose -f compose.build.yml build l4t-core
docker compose -f compose.build.yml build l4t-base
docker compose -f compose.build.yml build l4t-full
docker compose -f compose.build.yml build l4t-desktop

# Cross-compile
DOCKER_DEFAULT_PLATFORM=linux/arm64 docker compose -f compose.build.yml build core
```

## Image Tags

Standard: `adi_ros2:<distro>-<stage>` (e.g. `adi_ros2:humble-base`)

Jetson: `adi_ros2-l4t:<distro>-<stage>` (e.g. `adi_ros2-l4t:humble-base`)