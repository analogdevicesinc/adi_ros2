.. _ROS2 Documentation Guide:

ROS2 Documentation Guide
================================================================================

.. contents:: Table of Contents
  :depth: 1
  :local:

Overview
--------------------------------------------------------------------------------

This guide explains how to build and generate documentation for the ADI ROS2
repository. The documentation system uses `rosdoc2`_ to generate both custom
documentation (tutorials, guides) and auto-generated API references from source code.
The documentation styling follows Analog Devices guidelines through the use of
`Analog Devices Doctools`_, which ensures consistent branding and appearance
across all ADI documentation.

.. tip::
    The documentation build process requires all repository submodules to be
    initialized. Make sure you've cloned the repository with submodules as
    or updated them using:

    .. code-block:: bash

        git submodule update --init --recursive --remote

Prerequisites
--------------------------------------------------------------------------------

Before building documentation, ensure you have:

- **Python 3.10+**: The documentation tools have been tested with Python 3.10
- **Git submodules initialized**: Required for building complete documentation
- **ROS2 packages**: Some API documentation requires ROS2 package metadata

Setting Up the Environment
--------------------------------------------------------------------------------

To ensure a consistent build environment, set up a Python virtual environment:

1. **Navigate to the repository root:**

   .. code-block:: bash

       cd /path/to/adi_ros2

2. **Create and activate a virtual environment:**

   .. code-block:: bash

       python3 -m venv .venv
       source .venv/bin/activate

3. **Install documentation dependencies:**

   .. code-block:: bash

       pip install -r src/adi_ros2/doc/requirements.txt

.. note::
    Keep the virtual environment activated throughout the documentation build process.

Understanding the Documentation Structure
--------------------------------------------------------------------------------

The ADI ROS2 documentation is organized in a hierarchical structure:

Repository Structure:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: text

    adi_ros2/
    ├── src/
    │   ├── adi_ros2/
    │   │   └── doc/                 # Meta-repository documentation
    │   │       ├── index.rst        # Main documentation entry point
    │   │       ├── conf.py          # Sphinx configuration
    │   │       └── Documentation/   # Guides, tutorials, etc.
    │   ├── adi_imu/
    │   │   └── doc/                 # Package-specific documentation
    │   ├── adi_tmcl/
    │   │   └── doc/                 # Package-specific documentation
    │   └── ...
    └── _build/                      # Generated documentation output

Documentation Levels:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **Meta-repository Documentation** (``src/adi_ros2/doc/``)

   - Overview of the entire ADI ROS2 ecosystem
   - Getting started guides
   - Docker setup instructions
   - Links to individual package documentation

2. **Package-Level Documentation** (``src/<package_name>/doc/``)

   - Detailed package descriptions
   - Installation and usage instructions
   - API references generated from source code
   - Package-specific examples

Key Configuration Files:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **conf.py**: Sphinx configuration defining build settings, theme, and extensions
- **index.rst**: Main entry point providing navigation and overview
- **rosdoc2.yaml**: Package-specific build configuration for rosdoc2

Building the Documentation
--------------------------------------------------------------------------------

The documentation build process uses an automated script that handles all packages:

1. **Run the Build Script**

   Execute the build script from the repository root:

   .. code-block:: bash

       ./ci/build_doc.sh

   This script will:

   - Set up the build environment
   - Process all packages with documentation
   - Generate API references from source code
   - Create cross-references between packages

2. **Monitor the Build Process**

   The build process will display progress information. Look for any error messages
   that might indicate missing dependencies or configuration issues.

3. **Examine the Output Structure**

   After successful completion, the documentation will be organized as:

   .. code-block:: text

       _build/
       ├── cross_reference/     # Cross-reference data for linking between packages
       ├── docs_build/          # Intermediate build files and logs
       └── docs_output/         # Final HTML documentation
           ├── adi_meta/        # Meta-repository documentation
           ├── adi_imu/         # Individual package documentation
           ├── adi_tmcl/        # Individual package documentation
           └── ...

4. **View the Documentation**

   Open the main documentation in your web browser:

   .. code-block:: bash

       # Open the main entry point
       xdg-open _build/docs_output/adi_meta/index.html

   Or navigate to specific package documentation:

   .. code-block:: bash

       # View specific package docs
       xdg-open _build/docs_output/adi_imu/index.html

Building Documentation for a Specific Package
--------------------------------------------------------------------------------

For development and testing, you can build documentation for individual packages:

.. code-block:: bash

    # Create build directory if it doesn't exist
    mkdir -p _build
    cd _build

    # Build specific package documentation
    rosdoc2 build --package-path ../src/adi_imu --debug

.. tip::
    Use the ``--debug`` flag to get detailed output when troubleshooting
    documentation build issues.

Troubleshooting
--------------------------------------------------------------------------------

Common Issues and Solutions:

**Missing Dependencies:**
  If you encounter import errors, ensure all Python dependencies are installed:

  .. code-block:: bash

      pip install -r src/adi_ros2/doc/requirements.txt

**Submodule Issues:**
  The Git submodules may not be initialized or updated. Ensure you have
  cloned the repository with submodules or run the following command to
  initialize and update them:

  .. code-block:: bash

      git submodule update --init --recursive --remote

**Permission Errors:**
  Ensure the build script is executable:

  .. code-block:: bash

      chmod +x ci/build_doc.sh


Contributing to Documentation
--------------------------------------------------------------------------------

When contributing to the documentation:

1. **Follow reStructuredText conventions** for consistency
2. **Test your changes** by building the documentation locally
3. **Update both content and structure** when adding new packages
4. **Include examples and code snippets** to illustrate usage

.. warning::
    **Documentation Update Workflow**

    - **Meta-repository changes** (``src/adi_ros2/doc/``): Commit changes directly
      to this repository.

    - **Package-specific changes** (``src/<package_name>/doc/``): Make updates in
      the individual package repository, merge changes to the main branch (currently
      ``humble``), then update the submodule reference in this repository

.. note::
  Changes merged to the main branch of the adi_ros2 repository will
  automatically trigger a documentation build in the CI pipeline, ensuring
  that the latest documentation is always available.


.. _Analog Devices Inc: https://www.analog.com
.. _rosdoc2: https://github.com/ros-infrastructure/rosdoc2
.. _Analog Devices Doctools: https://github.com/analogdevicesinc/doctools
.. _Sphinx documentation: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html