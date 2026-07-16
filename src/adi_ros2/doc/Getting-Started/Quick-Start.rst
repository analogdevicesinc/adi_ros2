.. _quick-start:

Quick Start
================================================================================

.. contents:: On This Page
   :depth: 2
   :local:

Build an ADI Robotics SDK image, open a shell in the container, and verify the
environment is ready.


1. Clone the Repository
--------------------------------------------------------------------------------

Clone the meta-repository with all submodules:

.. code-block:: bash

    git clone --recurse-submodules https://github.com/analogdevicesinc/adi_ros2.git
    cd adi_ros2

If you already cloned without submodules:

.. code-block:: bash

    git submodule update --init --recursive

.. note::

    All build commands below are run from the repository root.


2. Image Stages
--------------------------------------------------------------------------------

The available stages are ``core``, ``base``, ``full``, and ``desktop``.

.. note::

   See :ref:`supported-platforms` for a description of each variant, what it
   includes, and image sizes.


.. _select-distro:

3. Select the ROS2 Distribution
--------------------------------------------------------------------------------

Every build and run command is parameterized by the ``ROS_DISTRO`` environment
variable. It selects **two** things at once: the ROS2 base image the image is
built ``FROM``, and the set of ADI packages compiled into it (via the matching
``docker/adi_ros2-<distro>.yml`` source manifest).

.. list-table::
   :header-rows: 1
   :widths: 20 32 48

   * - ``ROS_DISTRO``
     - Source manifest
     - Packages included
   * - ``humble``
     - ``docker/adi_ros2-humble.yml``
     - Full SDK — IIO, IMU, TMC motor control, 3D ToF, and dependencies
   * - ``jazzy``
     - ``docker/adi_ros2-jazzy.yml``
     - ``adi_iio`` + ``adi_imu``
   * - ``lyrical``
     - ``docker/adi_ros2-lyrical.yml``
     - ``adi_iio`` + ``adi_imu``

The default value is defined in the repository ``.env`` file. Override it for a
single command:

.. code-block:: bash

    ROS_DISTRO=jazzy docker compose -f compose.build.yml build base

Or edit ``.env`` to change the default for every command:

.. code-block:: bash

    ROS_DISTRO=jazzy

.. note::

   A distribution can only be selected if a matching
   ``docker/adi_ros2-<distro>.yml`` manifest exists — the build copies this file
   by name. The package set differs per distribution because not every ADI
   package has been ported to every ROS2 release. See :ref:`packages` for the
   per-distribution package coverage and how to add a new distribution.


4. Build Your First Image
--------------------------------------------------------------------------------

The ``docker compose`` commands use ``compose.build.yml``, which declares the
build targets, Dockerfiles, tags, and build arguments for this repository.

Build the ``base`` image:

.. code-block:: bash

    docker compose -f compose.build.yml build base

.. note::

   The first build downloads base images and compiles all ADI packages from
   source — expect **15–30 minutes** depending on your hardware. Subsequent
   builds use Docker's layer cache and are much faster.

Verify the image was created:

.. code-block:: bash

    docker images | grep adi_ros2

You should see ``adi_ros2`` tagged ``<distro>-base`` — for example
``adi_ros2:humble-base``, or ``adi_ros2:jazzy-base`` if you selected ``jazzy``.


.. _build-all-targets:

5. Build All Targets
--------------------------------------------------------------------------------

From the repository root, use ``compose.build.yml`` for standard and L4T
targets.

Standard Targets (Native Architecture)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Build a specific standard target:

.. code-block:: bash

  docker compose -f compose.build.yml build core
  docker compose -f compose.build.yml build base
  docker compose -f compose.build.yml build full
  docker compose -f compose.build.yml build desktop

Or build all standard targets at once:

.. code-block:: bash

  docker compose -f compose.build.yml build

NVIDIA Jetson (L4T) Targets
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These images use ``docker/Dockerfile.l4t`` and target JetPack 6.x
(``L4T_VERSION=r36.2.0`` by default).

.. code-block:: bash

  docker compose -f compose.build.yml build l4t-core
  docker compose -f compose.build.yml build l4t-base
  docker compose -f compose.build.yml build l4t-full
  docker compose -f compose.build.yml build l4t-desktop

.. tip::

  To target a different L4T release:

  .. code-block:: bash

    L4T_VERSION=r36.3.0 docker compose -f compose.build.yml build l4t-base

Cross-Architecture Build (x86_64 Host -> ARM64 Image)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your Docker setup supports multi-platform builds, you can use Compose with
an explicit target platform:

.. code-block:: bash

  DOCKER_DEFAULT_PLATFORM=linux/arm64 docker compose -f compose.build.yml build base

Or use Docker Buildx directly:

.. code-block:: bash

  docker buildx build --platform linux/arm64 --target base -f docker/Dockerfile .

Replace ``--target base`` with ``core``, ``full``, or ``desktop`` as needed.

.. note::

   Cross-platform builds require BuildKit/Buildx and emulation support (QEMU).
   See Docker's setup guides:

   - `Multi-platform builds <https://docs.docker.com/build/building/multi-platform/>`_
   - `Build drivers and builders <https://docs.docker.com/build/builders/>`_


6. Run a Container
--------------------------------------------------------------------------------

Interactive Shell
^^^^^^^^^^^^^^^^^^

Start an interactive container from the ``base`` image:

This command can be run from any directory after the image is built. Use the
tag matching the distribution you built (``humble-base`` shown here):

.. code-block:: bash

    docker run -it --rm --net=host --ipc=host adi_ros2:humble-base

Verify the environment is loaded:

.. code-block:: bash

    ros2 pkg list | grep adi

7. Verify the Container Environment
--------------------------------------------------------------------------------

Once inside the container shell, run the following checks:

.. code-block:: bash

    # ROS distro is set
    echo $ROS_DISTRO

    # ADI packages are visible
    ros2 pkg list | grep adi

    # Core tooling is available
    ros2 --help
    colcon --help

If these commands run successfully, the container is ready.
