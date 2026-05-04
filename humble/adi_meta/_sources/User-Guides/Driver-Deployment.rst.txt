.. _driver-deployment:

Driver Deployment
================================================================================

.. contents:: On This Page
   :depth: 2
   :local:

The ADI Robotics SDK images contain all drivers. For production, you typically
need only one. This guide shows how to extract a single driver into a minimal
image, using ``adi_iio`` as the example. The same pattern should work for any package.

The demo files live in ``docker/demo/adi_iio/``.


Prerequisites
--------------------------------------------------------------------------------

Build the ``core`` image first — it provides the compiled packages and their
dependency manifests:

.. code-block:: bash

   # From the repository root
   docker compose -f compose.build.yml build core


How It Works
--------------------------------------------------------------------------------

The SDK builds each package into its own directory under
``/opt/ros/adi_ros2/<package>/``. Each package carries an ``exec_debs.txt`` file
listing its runtime ``apt`` dependencies. The minimal Dockerfile copies one
package out of ``core`` and installs only its dependencies:

.. code-block:: dockerfile

   FROM adi_ros2:${ROS_DISTRO}-core AS sdk

   FROM ros:${ROS_DISTRO}-ros-core

   # Copy one package from the SDK image
   COPY --from=sdk ${OVERLAY}/adi_iio ${OVERLAY}/adi_iio

   # Install only this package's runtime dependencies
   RUN apt-get update \
     && xargs -r apt-get install -y < ${OVERLAY}/adi_iio/share/adi_iio/exec_debs.txt \
     && rm -rf /var/lib/apt/lists/*


Build and Run
--------------------------------------------------------------------------------

.. code-block:: bash

   # From docker/demo/adi_iio/
   docker compose build
   docker compose up adi_iio

   # Ctrl+C to stop the node

   # Stop and remove the container
   docker compose down

The compose file defines two services:

.. list-table::
   :header-rows: 1
   :widths: 25 15 60

   * - Service
     - Profile
     - Purpose
   * - ``adi_iio_node``
     - default
     - Builds the minimal image and runs the driver node
   * - ``shell``
     - ``debug``
     - Interactive bash shell for inspection


Debug Shell
--------------------------------------------------------------------------------

.. code-block:: bash

   docker compose run --rm shell

Inside the container:

.. code-block:: bash

   ros2 run adi_iio adi_iio_node

