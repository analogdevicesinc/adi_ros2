# syntax=docker/dockerfile:1

ARG ROS_DISTRO=humble
ARG OVERLAY=/opt/ros/adi_ros2
ARG WORKSPACE=/adi_ros2_ws
ARG VERSION=1.0.0

###########################################
# Cacher: clone sources, extract manifests
###########################################
FROM ros:${ROS_DISTRO}-ros-base AS cacher

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG ROS_DISTRO
ARG WORKSPACE

WORKDIR ${WORKSPACE}

COPY docker/adi_ros2-${ROS_DISTRO}.yml ./

RUN mkdir -p src \
  && . /opt/ros/${ROS_DISTRO}/setup.sh \
  && vcs import --recursive src < adi_ros2-${ROS_DISTRO}.yml

# Extract only package manifests — source changes won't bust the rosdep cache
RUN mkdir -p /tmp/manifests \
  && find src \( -name "package.xml" -o -name "COLCON_IGNORE" \) \
     -print0 | xargs -0 -I{} cp --parents {} /tmp/manifests/

# Generate per-package exec dependency files
RUN bash -e <<'EOF'
set -euo pipefail
mkdir -p /tmp/pkg_debs

while IFS= read -r -d '' pkg_xml; do
    pkg_dir="$(dirname "${pkg_xml}")"
    pkg_name="$(grep -m1 '<name>' "${pkg_xml}" \
        | sed 's|.*<name>\(.*\)</name>.*|\1|')"
    [ -z "${pkg_name}" ] && continue

    debs="$(rosdep install -y \
        --from-paths "${pkg_dir}" \
        --ignore-src \
        --reinstall \
        --dependency-types=exec \
        --simulate 2>/dev/null \
        | grep 'apt-get install' \
        | awk '{gsub(/'"'"'/,"",$4); print $4}' \
        | sort -u)" || true

    printf '%s\n' ${debs} > "/tmp/pkg_debs/${pkg_name}.txt"
done < <(find /tmp/manifests/src -name 'package.xml' -print0)

# Combined: union of all per-package files
find /tmp/pkg_debs -name '*.txt' -print0 \
    | xargs -0 sort -u > /tmp/pkg_debs/ALL.txt
EOF

#######################################################
# Builder: compile the ADI Robotics SDK from sources
#######################################################
FROM ros:${ROS_DISTRO}-ros-base AS builder

ARG ROS_DISTRO
ARG OVERLAY
ARG WORKSPACE

ENV DEBIAN_FRONTEND=noninteractive

# System build dependencies
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
      apt-utils \
      build-essential \
      ccache \
      cmake \
      git \
      python3-vcstool

# Install rosdep deps using manifests
WORKDIR ${WORKSPACE}
COPY --from=cacher /tmp/manifests/ ./
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && bash -c '. /opt/ros/${ROS_DISTRO}/setup.sh && rosdep update --rosdistro ${ROS_DISTRO} && rosdep install -y --from-paths src --ignore-src'

# Copy full source
COPY --from=cacher ${WORKSPACE}/src ./src/

# Build all ADI ROS2 packages: sequential and single-threaded build to avoid memory issues
# hadolint ignore=SC2086
RUN --mount=type=cache,target=/root/.ccache \
    . /opt/ros/${ROS_DISTRO}/setup.sh \
  && SKIP_ARGS="" \
  && if [ "$(uname -m)" = "aarch64" ]; then \
       SKIP_ARGS="--packages-skip adi_3dtof_safety_bubble_detector adi_3dtof_floor_detector"; \
     fi \
  && export MAKEFLAGS="-l1 -j1" \
  && colcon build \
      --executor sequential \
      --install-base ${OVERLAY} \
      --cmake-args \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_COMPILER_LAUNCHER=ccache \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
      ${SKIP_ARGS}

# Embed per-package exec_debs.txt into overlay share directories
COPY --from=cacher /tmp/pkg_debs/ /tmp/pkg_debs/
RUN for txt in /tmp/pkg_debs/*.txt; do \
      pkg_name="$(basename "${txt}" .txt)"; \
      share_dir="${OVERLAY}/${pkg_name}/share/${pkg_name}"; \
      if [ -d "${share_dir}" ]; then cp "${txt}" "${share_dir}/exec_debs.txt"; fi; \
    done \
 && rm -rf /tmp/pkg_debs

# Generate build metadata in the ADI Robotics SDK
ARG VERSION
COPY docker/scripts/generate_build_metadata.py /tmp/generate_build_metadata.py
COPY docker/adi_ros2-${ROS_DISTRO}.yml ${OVERLAY}/adi_ros2-${ROS_DISTRO}.yml
RUN python3 /tmp/generate_build_metadata.py \
        "${OVERLAY}" "${ROS_DISTRO}" "${VERSION}" "${WORKSPACE}" \
    > /tmp/adi_ros2_welcome \
 && rm /tmp/generate_build_metadata.py

# Clean up build artifacts and source code
RUN rm -rf build/ log/ src/

ENV DEBIAN_FRONTEND=

###########################################
# Core: minimal runtime — embedded / edge devices
###########################################
FROM ros:${ROS_DISTRO}-ros-core AS core

ARG ROS_DISTRO
ARG OVERLAY
ARG VERSION

ENV OVERLAY=${OVERLAY}
ENV DEBIAN_FRONTEND=noninteractive

# Install exec runtime dependencies
COPY --from=cacher /tmp/pkg_debs/ALL.txt /tmp/exec_debs.txt
RUN --mount=type=cache,target=/etc/apt/apt.conf.d,from=cacher,source=/etc/apt/apt.conf.d \
    --mount=type=cache,target=/var/lib/apt/lists,from=cacher,source=/var/lib/apt/lists \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update && < /tmp/exec_debs.txt xargs -r apt-get install -y \
  && rm /tmp/exec_debs.txt

# Install Robotics SDK packages
COPY --from=builder ${OVERLAY} ${OVERLAY}

# Store source VCS manifest for reference
COPY docker/adi_ros2-${ROS_DISTRO}.yml ${OVERLAY}/adi_ros2-${ROS_DISTRO}.yml

# Generate multi-package setup.bash: enables discovery of the Robotics SDK packages in the image
COPY docker/scripts/setup.bash ${OVERLAY}/setup.bash
RUN chmod +x ${OVERLAY}/setup.bash

# Interactive shell configuration: source the overlay and show the welcome banner
COPY --from=builder /tmp/adi_ros2_welcome /etc/adi_ros2_welcome
COPY docker/scripts/bashrc_addon /tmp/bashrc_addon
RUN cat /tmp/bashrc_addon >> /etc/bash.bashrc && rm /tmp/bashrc_addon

# Entrypoint configuration: source the overlay before delegating to the command
# hadolint ignore=SC2016
RUN sed -i \
    's|exec "$@"|# Source ADI ROS2 overlay if present\nif [ -f "${OVERLAY}/setup.bash" ]; then\n    source "${OVERLAY}/setup.bash" --\nfi\n\nexec "$@"|' \
    /ros_entrypoint.sh

# ============================================================================
# Image metadata
# ============================================================================
LABEL maintainer="ADI Robotics Team <ros@analog.com>"
LABEL org.opencontainers.image.title="ADI Robotics SDK (core)"
LABEL org.opencontainers.image.description="Analog Devices ROS2 sensor drivers — minimal ros-core base for embedded deployments"
LABEL org.opencontainers.image.vendor="Analog Devices Inc."
LABEL org.opencontainers.image.source="https://github.com/analogdevicesinc/adi_ros2"
LABEL org.opencontainers.image.documentation="https://analogdevicesinc.github.io/adi_ros2/"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.version="${VERSION}"

ENV DEBIAN_FRONTEND=

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

###########################################
# Base: runtime image — ADI packages only
###########################################
FROM ros:${ROS_DISTRO}-ros-base AS base

ARG ROS_DISTRO
ARG OVERLAY
ARG VERSION

ENV OVERLAY=${OVERLAY}
ENV DEBIAN_FRONTEND=noninteractive

# Install exec runtime dependencies
COPY --from=cacher /tmp/pkg_debs/ALL.txt /tmp/exec_debs.txt
RUN --mount=type=cache,target=/etc/apt/apt.conf.d,from=cacher,source=/etc/apt/apt.conf.d \
    --mount=type=cache,target=/var/lib/apt/lists,from=cacher,source=/var/lib/apt/lists \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update && < /tmp/exec_debs.txt xargs -r apt-get install -y \
  && rm /tmp/exec_debs.txt

# Install Robotics SDK packages
COPY --from=builder ${OVERLAY} ${OVERLAY}

# Runtime utilities
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
      tmux \
      vim

# Store source VCS manifest for reference
COPY docker/adi_ros2-${ROS_DISTRO}.yml ${OVERLAY}/adi_ros2-${ROS_DISTRO}.yml

# Generate multi-package setup.bash: enables discovery of the Robotics SDK packages in the image
COPY docker/scripts/setup.bash ${OVERLAY}/setup.bash
RUN chmod +x ${OVERLAY}/setup.bash

# Interactive shell configuration: source the overlay and show the welcome banner
COPY --from=builder /tmp/adi_ros2_welcome /etc/adi_ros2_welcome
COPY docker/scripts/bashrc_addon /tmp/bashrc_addon
RUN cat /tmp/bashrc_addon >> /etc/bash.bashrc && rm /tmp/bashrc_addon

# Entrypoint configuration: source the overlay before delegating to the command
# hadolint ignore=SC2016
RUN sed -i \
    's|exec "$@"|# Source ADI ROS2 overlay if present\nif [ -f "${OVERLAY}/setup.bash" ]; then\n    source "${OVERLAY}/setup.bash" --\nfi\n\nexec "$@"|' \
    /ros_entrypoint.sh

# ============================================================================
# Image metadata
# ============================================================================
LABEL maintainer="ADI Robotics Team <ros@analog.com>"
LABEL org.opencontainers.image.title="ADI Robotics SDK"
LABEL org.opencontainers.image.description="Analog Devices ROS2 sensor drivers and core libraries (base)"
LABEL org.opencontainers.image.vendor="Analog Devices Inc."
LABEL org.opencontainers.image.source="https://github.com/analogdevicesinc/adi_ros2"
LABEL org.opencontainers.image.documentation="https://analogdevicesinc.github.io/adi_ros2/"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.version="${VERSION}"

ENV DEBIAN_FRONTEND=

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

###########################################
# Full: base + third-party robotics SDK
###########################################
FROM base AS full

ARG ROS_DISTRO
ARG OVERLAY
ARG VERSION
ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
      ros-${ROS_DISTRO}-navigation2 \
      ros-${ROS_DISTRO}-nav2-bringup \
      ros-${ROS_DISTRO}-slam-toolbox \
      ros-${ROS_DISTRO}-canopen \
      ros-${ROS_DISTRO}-imu-tools

LABEL maintainer="ADI Robotics Team <ros@analog.com>"
LABEL org.opencontainers.image.title="ADI Robotics SDK (full)"
LABEL org.opencontainers.image.description="ADI ROS2 sensor drivers with Navigation2, SLAM Toolbox, and CANopen support"
LABEL org.opencontainers.image.vendor="Analog Devices Inc."
LABEL org.opencontainers.image.source="https://github.com/analogdevicesinc/adi_ros2"
LABEL org.opencontainers.image.documentation="https://analogdevicesinc.github.io/adi_ros2/"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.version="${VERSION}"

ENV DEBIAN_FRONTEND=

###########################################
# Desktop: full + ROS visualization tools
###########################################
FROM full AS desktop

ARG ROS_DISTRO
ARG OVERLAY
ARG VERSION
ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
      ros-${ROS_DISTRO}-desktop

LABEL maintainer="ADI Robotics Team <ros@analog.com>"
LABEL org.opencontainers.image.title="ADI Robotics SDK (desktop)"
LABEL org.opencontainers.image.description="ADI ROS2 sensor drivers with full visualization suite (RViz2, rqt, and ROS desktop tools)"
LABEL org.opencontainers.image.vendor="Analog Devices Inc."
LABEL org.opencontainers.image.source="https://github.com/analogdevicesinc/adi_ros2"
LABEL org.opencontainers.image.documentation="https://analogdevicesinc.github.io/adi_ros2/"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.version="${VERSION}"

ENV DEBIAN_FRONTEND=

###########################################
# Dev: Development environment for devcontainers
###########################################
FROM osrf/ros:${ROS_DISTRO}-desktop-full AS dev

ARG ROS_DISTRO
ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

# Build toolchain and development tools
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
      # Build toolchain
      build-essential \
      ccache \
      cmake \
      git \
      python3-colcon-common-extensions \
      python3-colcon-mixin \
      python3-rosdep \
      python3-vcstool \
      # Debugging
      gdb \
      valgrind \
      # Code quality & formatting
      clang-format \
      clang-tidy \
      python3-flake8 \
      python3-pytest \
      shellcheck \
      # IDE / language server support
      python3-pip \
      # ROS ament linting
      ros-${ROS_DISTRO}-ament-clang-format \
      ros-${ROS_DISTRO}-ament-cmake-clang-format

# Source the base ROS2 distro in interactive shells opened by devcontainer
# (docker exec does not invoke the ENTRYPOINT, so /ros_entrypoint.sh is never run)
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc \
 && echo "command -v register-python-argcomplete3 > /dev/null 2>&1 && eval \"\$(register-python-argcomplete3 ros2)\"" >> /etc/bash.bashrc \
 && echo "command -v register-python-argcomplete3 > /dev/null 2>&1 && eval \"\$(register-python-argcomplete3 colcon)\"" >> /etc/bash.bashrc

ENV DEBIAN_FRONTEND=

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
