.. _Build ROS2 Documentation:

Build ROS2 Documentation
================================================================================

Overview
--------------------------------------------------------------------------------

This section provides a comprehensive guide on how to build and generate
documentation for the repository. It covers the necessary tools, setup
instructions, and steps to customize and automate the documentation process.

Setting Up the Environment
--------------------------------------------------------------------------------

To ensure a consistent build environment, it is recommended to set up a
Python3 virtual environment to manage dependencies. Follow these steps:

#. Open a terminal window.
#. Navigate to the root directory of your project `(adi_ros2)`.
#. Create a virtual environment:

  .. code-block:: bash

      python3 -m venv .venv

#. Activate the virtual environment:

  .. code-block:: bash

      source .venv/bin/activate

#. Install the required dependencies listed in the `requirements.txt` file under
   `adi_ros2/doc/requirements.txt`:

  .. code-block:: bash

      cd adi_ros2/doc
      pip install -r requirements.txt

Directory Structure
--------------------------------------------------------------------------------

The naming convention for ROS2 repositories provided by `Analog Devices Inc`_
follows the format: **adi-<repository_name>**.

For example, the meta-repository is named `adi_ros2`, which serves as an
umbrella for multiple Analog Devices ROS2 packages.

The `sphinx-quickstart` tool is used to generate the initial documentation
template. This tool will create the necessary directory structure and
configuration files for Sphinx.

Follow the prompts to configure your documentation project. This will create
files such as `index.rst` and `conf.py` and place them in the `doc` directory.

Documentation Structure:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The documentation is organized at two levels:

#. **Meta-repository Documentation**

    - The overall documentation for the ROS2 meta-repository is located in the
      root directory under:

      .. code-block:: bash

          src/adi_ros2/doc/

    - Provides an overview of the repository, environment setup, and references
      for using Analog Devices ROS2 packages.

#. **Package-Level Documentation**

    - Each individual package within the meta-repository contains its own
      documentation under:

      .. code-block:: bash

          src/<package_name>/doc/

    - Contains detailed descriptions, installation instructions, API references,
      and usage examples.

Key Files and Their Purpose
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **conf.py**: Sphinx configuration file to define documentation build settings.
- **index.rst**: entry point for documentation, providing an overview and
  navigation links.

Building the Documentation
--------------------------------------------------------------------------------

This section explains how to generate documentation using `rosdoc2`_, a
command-line tool for building documentation for ROS 2 packages.

To build the documentation, follow these steps:

1. Run the build script:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- A script is provided at `ci/build_doc.sh` to automate the documentation
  generation process. Execute the following command from the root of the
  repository:

  .. code-block:: bash

      ./ci/build_doc.sh

2. Review the generated documentation:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Once the script completes successfully, the generated documentation will be
  located in the `_build` directory:

  .. code-block:: text

      ├── _build
      │   ├── cross_reference    # Contains cross-reference data for API documentation
      │   ├── docs_build         # Intermediate build files
      │   └── docs_output        # Final documentation output

3. View the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- The main entry point for the generated documentation is the `index.html`
  file located at:

  .. code-block:: bash

      _build/docs_output/adi_meta/index.html

Open the file in a web browser to view the documentation.

4. (Optional) Build documentation for a specific package:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- To build documentation for a specific package, navigate to the package
  directory and run the following command:

  .. code-block:: bash

      cd _build
      rosdoc2 build --package-path ../adi_ros2 --debug

- This is useful when modifying documentation for a single package.

5. Additional Notes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- The build script generates both custom documentation (e.g., tutorials, guides)
  and auto-generated API references.
- Ensure that submodules and dependencies are initialized before building the
  documentation.

Conclusions
--------------------------------------------------------------------------------
By following these steps, you can build and generate documentation for the
repository. Contributions to improve the documentation are always welcome.

.. _Analog Devices Inc: https://www.analog.com
.. _rosdoc2: https://github.com/ros-infrastructure/rosdoc2