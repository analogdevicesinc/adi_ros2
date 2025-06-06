.. _ROS2 Docker Image Guide:

ROS2 Docker Image Guide
================================================================================

.. contents:: Table of Contents
  :depth: 1
  :local:


This guide explains how to build a Docker image containing the necessary system
dependencies for Analog Devices ROS2 packages. By using a Docker container, you
ensure that all library and tool versions are consistent across development and
testing environments—especially important for packages that cannot fully resolve
their system dependencies using the standard `Rosdep Tool`_.

.. tip::
    For a quick start, you can pull pre-built Docker images for your
    :ref:`host platform <Host Platforms>` directly from the Docker repository.


Why Use a Docker Image?
--------------------------------------------------------------------------------

#. **Consistent Environment**
    Docker containers provide a reproducible setup where all the necessary libraries
    and tools remain version-locked, reducing the chance of dependency conflicts or
    mismatched package versions.

#. **Simplified Setup**
    Instead of manually installing system dependencies for each new environment or
    developer machine, you can simply pull or build a Docker image that is
    pre-configured and ready to go.

#. **Isolated Dependencies**
    Using containers avoids cluttering your host OS with package installations,
    which is particularly useful when multiple projects or ROS2 distributions are
    in play.


Prerequisites
--------------------------------------------------------------------------------

- **Docker installed:** Ensure you have Docker installed and running on your
  system. Refer to the `official installation instructions`_.

- **ROS2 Knowledge:** Familiarity with `building and running ROS2 packages`_.


Cloning the Repository
--------------------------------------------------------------------------------

**Clone with Submodules:** Clone the repository containing the Analog Devices
ROS2 packages. Make sure to initialize and update the submodules to get all the
needed ADI ROS2 components (required for building the documentation):

.. code-block:: bash

    git clone https://github.com/analogdevicesinc/adi_ros2.git
    cd adi_ros2
    git submodule update --init --recursive --remote


Building the Docker Image
--------------------------------------------------------------------------------

The repository contains ready-to-use Dockerfiles for different architectures
and ROS2 distributions (``humble``).

**Dockerfile Locations:**

- **ARM64 and AMD64 platforms:** ``docker/adi_ros2/`` directory

  - ``humble-amd64.Dockerfile`` - For x86_64 systems
  - ``humble-arm64.Dockerfile`` - For ARM64 systems

- **Jetson platforms:** ``docker/adi_ros2-l4t/`` directory

  - ``humble-arm64.Dockerfile`` - For NVIDIA Jetson devices


Local Docker Build Example
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To build a Docker image use one of the available Dockerfiles you can run the
following command, replacing the Dockerfile path and image tag as needed:

.. code-block:: bash

    # Build AMD64 image for ROS2 Humble (base target)
    docker buildx build \
        --platform linux/amd64 \
        --file docker/adi_ros2/humble-amd64.Dockerfile \
        --target base \
        --progress plain \
        -t adi_ros2:humble-amd64-base .

.. note::
    Make sure to run the Docker build command from the root of the repository,
    as this is the expected build context.

Verify the Image Build
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

After building, verify that the image was created successfully:

.. code-block:: bash

    docker images | grep adi_ros2


Advanced: Build the Docker Image Using Scripts
--------------------------------------------------------------------------------

The ADI ROS2 Docker images use a template-based build system where Dockerfiles
are generated from Jinja2 templates defined in ``scripts/templates.yml``. This
approach allows for consistent configuration across multiple image variants and
architectures. The provided build scripts are primarily used to test changes
made to these templates before they are committed.

Two main scripts handle this workflow:

- **Generate Script (``generate.py``):** Creates Dockerfiles from templates
- **Build Script (``build.py``):** Builds specific image targets as defined in the template configuration


.. note::
    The required Python packages for these scripts are listed in
    ``scripts/requirements.txt``. The scripts have been tested with Python 3.10.12.

    Make sure to install them in a virtual environment before running the scripts.

    .. code-block:: bash

        python -m venv venv
        source venv/bin/activate
        pip install -r requirements.txt


Generate Script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The generate script is used to update Dockerfiles from Jinja2 templates. This
allows you to customize the build configuration without manually editing
Dockerfiles.

.. code-block:: bash

    # Generate Dockerfiles from templates
    ./scripts/generate.py

Build Script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The build script is used to build specific targets from a Dockerfile. You can
pass options to build a specific target defined in the ``templates.yml`` file.

To see the help menu and available options, run:

.. code-block:: bash

    # Help menu
    ./scripts/build.py --help

.. note::
    Ensure Docker engine is running before executing the build scripts, as they
    require Docker to build the images.

You can build a specific target and image combination as shown below. The
``--generate`` flag regenerates Dockerfiles from templates before building.
Available targets (e.g: ``base``, ``full``, etc.) and images
(e.g: ``humble-amd64``) are defined in ``scripts/templates.yml``.

.. code-block:: bash

    ./scripts/build.py --generate --no-push --no-clean --target full humble-arm64

**Command Options Explained:**

- ``--generate``: Regenerate Dockerfiles from templates before building
- ``--no-push``: Skip pushing the built image to a registry
- ``--no-clean``: Keep intermediate build containers for debugging
- ``--target``: Specify the build stage (``base``, ``full``, or ``desktop``)

**Example Workflow**

.. code-block:: bash

    # 1. Generate updated Dockerfiles from templates
    ./scripts/generate.py

    # 2. Build an image for testing template updates
    ./scripts/build.py --generate --no-push --no-clean --target desktop humble-amd64

.. tip::
    Using the ``scripts/generate.py`` also updates the CI and Docker Hub docs
    to reflect the latest changes in the Dockerfiles. The workflow described
    above is useful for testing new configurations during development.

.. warning::
    **Template Versioning Workflow**

    When making changes to templates, follow this workflow to maintain proper versioning:

    1. Make your template changes and run ``./scripts/generate.py`` to update
       Dockerfiles  .
    2. Commit these changes to git.
    3. Run ``./scripts/generate.py`` again to update the ``docker/README.md``
       with the previou     s commit SHA.

    This ensures the Docker Hub documentation references the exact repository
    state used when CI rebuilds the images.


.. _Rosdep Tool: https://docs.ros.org/en/humble/Tutorials/Intermediate/Rosdep.html
.. _official installation instructions: https://docs.docker.com/engine/install/
.. _building and running ROS2 packages: https://docs.ros.org/en/rolling/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html