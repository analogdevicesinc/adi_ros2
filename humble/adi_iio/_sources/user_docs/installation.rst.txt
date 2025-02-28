.. _installation:

Installation
================================================================================

This section describes how to install the required software to run the ``adi_iio``
package.

Build from Source
--------------------------------------------------------------------------------

Workspace setup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you are not using this node in an existing project, create a new folder ``ros2_ws``,
then create the ``src`` folder in ``ros2_ws``. Go to src folder (either in
ros2_ws or in your project), and clone the adi_iio repository:

.. code-block:: bash

    export COLCON_WS=~/ros2_ws/src
    mkdir -p $COLCON_WS
    cd $COLCON_WS
    git clone <https://github.com/your-repository-url.git>

After cloning, your directory structure should look like this:

.. code-block:: bash

    ros2_ws/
    └── src/
        └── adi_imu/

Source your main ROS2 environment as the underlay (in this example, ROS2 Humble):

.. code-block:: bash

    source /opt/ros/humble/setup.sh


.. _libiio_source_build:

Resolving dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Before building the workspace, you need to resolve the package dependencies.
From the root of your workspace, run the following command:

.. code-block:: bash

    rosdep update
    rosdep install -i --from-path src --rosdistro ${ROS_DISTRO} -y


.. note::
    **Optional: Build Libiio from Source**

    The `adi_iio` package supports an alternative method of installing the libiio dependency
    by building it from source. This is useful if you prefer to use a custom version
    of libiio instead of relying on the system-provided ``libiio-dev`` package via rosdep.

    To build libiio from source, run the provided installation script which offers two options:

    - Set the desired libiio version (default is ``libiio-v0``).
    - Specify the staging directory for the source build (default is ``$HOME/src``).

    For example:

    .. code-block:: bash

        # Optional exports
        export LIBIIO_VERSION=libiio-v0
        export STAGING_DIR=$HOME/src

        ./ci/install_dependencies.sh

    After the script completes, install the remaining package dependencies while skipping the
    system's libiio development package:

    .. code-block:: bash

        rosdep install --from-paths src --ignore-src -r -y --skip-keys libiio-dev


.. tip::

    If you already have all your dependencies, the console will return:

    .. code-block:: bash

        #All required rosdeps installed successfully

**Building the workspace:** you can now build your package using the command:

.. code-block:: bash

    colcon build

.. note::

    It is recommended that 1 terminal is dedicated to building the
    package/workspace to avoid complex issues as mentioned in
    `ROS2 Source the overlay <https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#source-the-overlay>`_ .

**Verify the build status:** once finished, check whether the build is successful
by looking for error messages.

If successful, you will see that colcon has created new directories:

.. code-block:: bash

    ros2_ws/
    ├── build/
    ├── install/
    └── log/
    └── src/

The install directory is where your workspace’s setup files are, which you can
use to source your overlay.

.. warning::

    Before sourcing the overlay, it is very important that you open a new
    terminal, separate from the one where you built the workspace.

**Sourcing the overlay:** in the new terminal, enter the root of your workspace
and source your main ROS 2 environment as the underlay:

.. code-block:: bash

    cd $COLCON_WS
    source /opt/ros/humble/setup.sh

Then source the previously built overlay:

.. code-block:: bash

    source install/setup.sh

Now you can run the *adi_iio* package.


Building the Documentation
================================================================================

This guide describes how to build the project documentation locally using
**rosdoc2**. Follow the steps below to set up your environment, build the
documentation, and view the results.

Prerequisites
-------------
- **Python 3:** Ensure you have Python 3 installed.
- **Virtual Environment:** It is highly recommended to set up a Python virtual
  environment to avoid conflicts with other projects.
- **Dependencies:** All required dependencies are listed in ``doc/requirements.txt``.

Setting Up the Virtual Environment
--------------------------------------------------------------------------------

1. **Create the Virtual Environment**

   .. code-block:: bash

      python3 -m venv .venv

2. **Activate the Virtual Environment**

   .. code-block:: bash

      source .venv/bin/activate

3. **Install the Required Dependencies**

   .. code-block:: bash

      pip3 install -r doc/requirements.txt

Building the Documentation
--------------------------------------------------------------------------------

With the environment set up, build the documentation by running the following
command from the root of the project:

.. code-block:: bash

   rosdoc2 build --package-path .

This command generates the following directory structure:

.. code-block:: bash

   ./
   ├── cross_references/
   ├── docs_build/
   └── docs_output

Viewing the Documentation
--------------------------------------------------------------------------------

To view the generated documentation, open the ``docs_output/adi_iio/index.html``
file in your web browser.

Additional Notes
--------------------------------------------------------------------------------

- **Execution Directory:** All commands should be executed from the project’s
  root directory.
- **Troubleshooting:** For any issues during the build process, refer to the
  official `rosdoc2 documentation <https://github.com/ros-infrastructure/rosdoc2>`_.
