.. _supported-platforms:

Supported Platforms
================================================================================

.. contents:: On This Page
   :depth: 2
   :local:


Supported ROS2 Distributions
--------------------------------------------------------------------------------

* `ROS2 Humble Hawksbill`_ (Ubuntu 22.04 LTS)
* `ROS2 Jazzy Jalisco`_ (Ubuntu 24.04 LTS)
* `ROS2 Lyrical`_ (Ubuntu 26.04 LTS)

The distribution is selected at build time with the ``ROS_DISTRO`` environment
variable, which chooses both the ROS2 base image and the set of ADI packages
compiled into the image. See :ref:`select-distro` for how to select a
distribution and :ref:`packages` for per-distribution package coverage.


Host Platforms
--------------------------------------------------------------------------------

The ADI Robotics SDK provides Docker images for the following host architectures:

.. list-table::
   :header-rows: 1
   :widths: 20 30 50

   * - Platform
     - Dockerfile
     - Use Cases

   * - **x86_64** (``amd64``)
     - ``docker/Dockerfile``
     - Development workstations, servers, edge computing devices.

   * - **ARM64** (``arm64``)
     - ``docker/Dockerfile``
     - ARM-based SBCs and servers (e.g. Raspberry Pi 4+).

   * - **NVIDIA Jetson** (``arm64``)
     - ``docker/Dockerfile.l4t``
     - Jetson Orin, Jetson AGX, and other L4T-based Jetson platforms.

.. note::
   Use the provided Dockerfiles and build infrastructure to build and
   customize your own containerized deployment of the ADI ROS2 drivers.
   See :ref:`quick-start` for instructions.

.. warning::
   Hardware-specific features (IMU, IIO devices, motor controllers) may require
   the corresponding device drivers on the host system. The Docker container
   provides the ROS2 software stack, not the kernel drivers.

Image Variants
--------------------------------------------------------------------------------

Each platform provides four image variants built as Docker multi-stage targets:

.. list-table::
   :header-rows: 1
   :widths: 20 20 60

   * - Variant (``--target``)
     - Approximate Size
     - Contents

   * - ``core``
     - ~750 MB
     - Minimal runtime — ``ros-core`` + all ADI ROS2 packages compiled from
       source, installed to ``/opt/ros/adi_ros2``. Use this variant for
       space-constrained deployments on target hardware.

   * - ``base``
     - ~1.3 GB
     - ``ros-base`` + all ADI ROS2 packages + shell utilities (tmux, vim).
       Use this variant for driver deployment when you need a more comfortable
       shell environment.

   * - ``full``
     - ~3.6 GB
     - Everything in ``base`` + Navigation2, SLAM Toolbox, CANopen, and IMU
       Tools. Use this variant when you need the full robotics stack alongside
       ADI hardware drivers.

   * - ``desktop``
     - ~5.2 GB
     - Everything in ``full`` + ROS2 desktop (RViz2, rqt, and GUI tooling).
       Use this variant for development workstations.


.. _ROS2 Humble Hawksbill: https://docs.ros.org/en/humble/Releases/Release-Humble-Hawksbill.html
.. _ROS2 Jazzy Jalisco: https://docs.ros.org/en/jazzy/Releases/Release-Jazzy-Jalisco.html
.. _ROS2 Lyrical: https://docs.ros.org/en/lyrical/Releases/Release-Lyrical-Luth.html
