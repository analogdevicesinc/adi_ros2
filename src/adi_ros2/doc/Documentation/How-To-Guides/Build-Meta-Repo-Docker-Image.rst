.. _build_docker_image:

Build Docker Image with Analog Devices ROS2 Packages
================================================================================

.. contents:: Table of Contents
  :depth: 1
  :local:

This guide explains how to build a Docker image containing the necessary system
dependencies for Analog Devices ROS2 packages. By using a Docker container, you
ensure that all library and tool versions are consistent across development and
testing environments—especially important for packages that cannot fully resolve
their system dependencies using the standard `rosdep tool <https://docs.ros.org/en/humble/Tutorials/Intermediate/Rosdep.html>`_.


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
  system. Refer to the
  `official installation instructions <https://docs.docker.com/engine/install/>`_.

- **ROS2 Knowledge:** Familiarity with
  `building and running ROS2 packages <https://docs.ros.org/en/rolling/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html>`_.

- **Git Submodules:** Understand how to properly
  `clone and update submodules <https://git-scm.com/book/en/v2/Git-Tools-Submodules>`_.


Cloning the Repository
--------------------------------------------------------------------------------

1. **Create a ROS2 Workspace:** it is good practice to keep your ROS2 packages
under a common workspace directory, for example:

.. code-block:: bash

    export ROS2_WS=$(pwd)/ros2_ws

    mkdir -p $ROS2_WS/src
    cd $ROS2_WS/src

2. **Clone with Submodules:** Clone the repository containing the Analog Devices
ROS2 packages. Make sure to initialize and update the submodules to get all the
needed ADI ROS2 components:

.. code-block:: bash

    git clone --recurse-submodules --branch humble-develop https://github.com/adi-innersource/adi_ros2.git

3. **Optional: Review Dependencies:** The repository includes a
`ci/install_dependencies.sh` script that can be run to install the system-level
dependencies from source. This script is automatically called within the Docker
build, but you can also run it locally for troubleshooting if needed:


Building the Docker Image
--------------------------------------------------------------------------------

A Docker image for your desired ROS2 distribution `(e.g., humble)` can be built
using the provided scripts within the repository starting from the official
`Docker ROS base images <https://hub.docker.com/_/ros/>`_.

1. **Navigate to the Docker Build Script and run it:** From the root of the cloned
repository (adi_ros2), you can run:

.. code-block:: bash
    cd $ROS2_WS/src/adi_ros2
    ./ci/docker/docker_build.sh

You can manually specify the ROS2 distribution you want to build the image for
by changing the `ROS_DISTROS` variable in the script before running it.

2. **Verify the Image Build:** The script will build the Docker image with the
tag `adi_ros2:${ROS_DISTRO}-dev`. Verify that the image is successfully built
and ready for use by running:

.. code-block:: bash

    docker images | grep adi_ros2


Running the Docker Container
--------------------------------------------------------------------------------

After the image is built, you can run a container and mount your local ROS2
workspace into it. This allows you to build and test packages inside the
container while still preserving build artifacts on your host.

1. **Move to Your Workspace:** Ensure you are in the root of your ROS2 workspace
`(e.g., ros2_ws)` so you can mount the entire workspace into the container:

.. code-block:: bash

    cd $ROS2_WS

2. Run the Container

Use the following command to start a container in **interactive mode** `(-it)` and
**remove it automatically on exit** `(--rm)`. The `-v $(pwd)/src:/overlay_ws/src` argument
mounts your `adi_ros2` repository into `/overlay_ws` inside the container.

.. code-block:: bash

    docker run -it --rm \
        -v $(pwd)/src/adi_ros2:/overlay_ws/src \
        -v $(pwd)/install:/overlay_ws/install \
        -v $(pwd)/build:/overlay_ws/build \
        -v $(pwd)/log:/overlay_ws/log \
        adi_ros2:humble-dev /bin/bash

3. Build the ROS2 Packages

Once inside the container, you can install additional ROS2 dependencies if needed
via **rosdep** and then build your packages:

.. code-block:: bash

    # Navigate to the overlay workspace
    cd $OVERLAY_WS

    # Install any missing dependencies declared in package.xml
    rosdep install -i --from-path src --rosdistro ${ROS_DISTRO} -y

    # Build the ROS2 packages. Make sure to follow any extra requirements for
    # the specific package you are building. Some packages may require additional
    # steps to build successfully such as exporting the required environment variables.
    colcon build \
        --packages-up-to adi_meta \
        --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo

You can also source your workspace to test or run nodes:

.. code-block:: bash

    source install/setup.bash

    # Now you can run or launch you ADI ROS2 nodes, for example:
    ros2 run <your_package> <your_node>


Tips and Best Practices
--------------------------------------------------------------------------------

1. Environment Variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Confirm that you are building the Docker Image for the correct ROS2
  distribution. For this verify that the ROS_DISTROS variable from the `ci/docker/docker_build.sh`
  script is set to the desired ROS2 distribution.

2. Preserving Data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- The container is ephemeral if you use --rm. All build artifacts remain in your
  host machine’s ros2_ws/build, ros2_ws/install, etc. directories because of the
  volume mount. This approach allows you to reuse these artifacts even after the
  container is stopped.

3. Rebuilding After Changes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- If you change system-level dependencies or if the base Dockerfile updates,
  rebuild your image to keep everything in sync.

4. Using the build artifacts in the host machine
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- The `ros2_ws` directory in the host machine is mounted into the container. This
  allows you to build and test packages inside the container while preserving
  build artifacts on your host. If you want to use the build artifacts in the
  host machine, you can source the install/setup.bash file from the host machine.

- Make sure to to run the following command to use the build artifacts in the
  host machine:

.. code-block:: bash

    export COLCON_CURRENT_PREFIX=$ROS2_WS/install


Conclusions
--------------------------------------------------------------------------------

By following these steps, you can ensure that all system dependencies for Analog
Devices ROS2 packages are correctly installed and configured. This Docker-based
approach simplifies the development and testing process, providing a consistent
environment for building and running ROS2 nodes.