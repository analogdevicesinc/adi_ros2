Analog Devices ROS2
================================================================================

Welcome to `Analog Devices Inc`_ ROS2 documentation!


.. toctree::
   :titlesonly:
   :maxdepth: 2
   :includehidden:

   Documentation


.. contents:: Table of Contents
    :depth: 1


.. _Overview:

Overview
================================================================================

The Analog Devices Robotics SDK provides a collection of ROS2 packages and 3rd
party tools for robotics applications.
The `adi_ros2 Github Repository`_ aggregates various ADI ROS2 packages into
pre-configured Docker images, offering a ready-to-use environment for diverse
hardware platforms.

.. _Supported Platforms:

Supported Platforms
================================================================================

The Analog Devices Robotics SDK Docker images are available for multiple platforms
and architectures to support diverse hardware deployments:

.. _Host Platforms:

Host Platforms
--------------------------------------------------------------------------------

.. list-table::
  :header-rows: 1
  :widths: 25 30 50

  * - Platform
    - Docker Repository
    - Use Cases

  * - **x86_64** (``amd64``)
    - `astanea/adi_ros2`_
    - Development workstations, servers, edge computing devices, etc.

  * - **ARM64** (``arm64``)
    - `astanea/adi_ros2`_
    - ARM-based servers, development boards (Raspberry Pi 4+), etc.

  * - **Jetson** (``arm64``)
    - `astanea/adi_ros2-l4t`_
    - The image targets NVIDIA's official L4T base image for Jetson platforms.


Docker Image Variants
================================================================================

The Analog Devices SDK provides three Docker image variants that incrementally
add more packages to address different user requirements:

.. list-table::
  :header-rows: 1
  :widths: 15 85

  * - Variant
    - Description

  * - **base**
    - Includes a basic ROS2 installation plus all Analog Devices ROS2 packages
      and their dependencies.

  * - **full**
    - Builds upon the base stage by adding popular 3rd party tools such as
      Navigation2, SLAM Toolbox, and CANopen for advanced robotics applications.

  * - **desktop**
    - Extends the full stage with essential ROS desktop packages, providing
      development and visualization tools like RViz, rqt, and other GUI applications.

.. warning::
  While the SDK is containerized and should work on any Docker-compatible host,
  hardware-specific features (IMU, IIO devices, motor controllers) require
  appropriate driver support on the host system.

Supported ROS2 Distributions:
--------------------------------------------------------------------------------

* `ROS2 Humble Hawksbill`_ (Ubuntu 22.04 LTS base)


.. _Getting Started:

Getting Started
================================================================================

.. note::
  For a quick start, it is recommended to use one of the pre-build Docker images.
  These images contain pre-built ROS2 packages installed in an overlay at
  ``/opt/ros/adi_ros2`` which is automatically sourced when the container starts.

  For a complete list of available tags and image variants, visit one of the
  **Docker repositories** listed in the `Host Platforms`_ section.

1. **Pull the Docker Image**

  To get started, you can pull the latest version of your desired image from
  Docker Hub. For example:

  .. code-block:: shell

    sudo docker pull astanea/adi_ros2:humble-amd64-desktop

2. **Run the Docker Container**

  To run the container:

  * (`Optional``) Allow external applications to connect to the host's display
    (for GUI applications):

    .. code-block:: shell

      xhost +

  * Run the Docker container with the necessary options:

    .. code-block:: shell

      sudo docker run \
            -it --rm \
            --net=host \
            --ipc=host \
            --privileged \
            --env="DISPLAY" \
          astanea/adi_ros2:humble-amd64-desktop

  Arguments explained:

    - ``-it``: Run the container in interactive mode with a TTY.
    - ``--rm``: Automatically remove the container when it exits.
    - ``--net=host``: Use the host's network stack.
    - ``--ipc=host``: Share the host's IPC namespace, useful for inter-process
      communication.
    - ``--privileged``: Grant extended privileges to the container for hardware
      access.

3. **Run Examples**

  Once inside the container, you can run examples from any of the ADI ROS2 packages.
  Each package in the `Repositories and Packages`_ section below contains
  documentation with ROS2 command snippets and usage examples to get you started.

.. _repositories:

Repositories and Packages
================================================================================

Use this index to find the ROS2 packages you need provided by
`Analog Devices Inc`_ as well as examples on how to use them.


.. list-table::
  :header-rows: 1
  :widths: 15 15 20 50

  * - Repository Docs
    - Package Name
    - API Docs
    - Description

  * - `adi_ros2`_
    - ``adi_meta``
    - N/A
    - This package serves as a meta-package that aggregates all ROS2 packages
      provided by `Analog Devices Inc`_. It simplifies the installation
      process by providing a single package that depends on all individual
      ROS2 packages, ensuring that users can quickly and easily install the
      entire ADI suite.

  * - `iio_ros2`_
    - ``adi_iio``
    - `adi_iio API`_
    - This package interfaces with IIO devices, providing a comprehensive
      framework for integrating industrial I/O systems into modern robotics
      solutions. It offers services to read/write IIO attributes, manage IIO
      buffers, and attach topics to these attributes/buffers.

  * - `imu_ros2`_
    - ``adi_imu``
    - `adi_imu API`_
    - A package offering precision MEMS IMU integration with
      factory-calibrated gyroscopes and accelerometers, ensuring accurate
      motion data for robotics applications.

  * - `tmcl_ros2`_
    - ``adi_tmcl``
    - `adi_tmcl API`_
    - adi_tmcl (previously tmcl_ros2) is the official ROS2 Driver for ADI
      Trinamic Motor Controllers (TMC) that uses Trinamic Motion Control
      Language (TMCL) protocol.

  * - `adi_3dtof_adtf31xx`_
    - ``adi_3dtof_adtf31xx``
    - `adi_tmcl API`_
    - The ADI 3DToF ADTF31xx is a ROS (Robot Operating System) package for working
      with ADI’s ADTF3175D ToF sensor. This node captures the Depth and AB
      frames from the sensor and publishes them as ROS topics.


.. _Analog Devices Inc: https://www.analog.com
.. _ROS2 Humble Hawksbill: https://docs.ros.org/en/humble/Releases/Release-Humble-Hawksbill.html

.. _Docker Hub Repository: https://hub.docker.com/repository/docker/astanea/adi_ros2/general
.. _astanea/adi_ros2: https://hub.docker.com/repository/docker/astanea/adi_ros2/general
.. _astanea/adi_ros2-l4t: https://hub.docker.com/repository/docker/astanea/adi_ros2-l4t/general
.. _adi_ros2 Github Repository: https://github.com/analogdevicesinc/adi_ros2

.. _adi_ros2: ./index.html

.. _iio_ros2: ../adi_iio/index.html#http://
.. _adi_iio API: ../adi_iio/generated/index.html#http://

.. _imu_ros2: ../adi_imu/index.html#http://
.. _adi_imu API: ../adi_imu/generated/index.html#http://

.. _tmcl_ros2: ../adi_tmcl/index.html#http://
.. _adi_tmcl API: ../adi_tmcl/generated/index.html#http://

.. _adi_3dtof_adtf31xx: ../adi_3dtof_adtf31xx/index.html#http://
.. _adi_3dtof_adtf31xx API: ../adi_3dtof_adtf31xx/generated/index.html#http://
