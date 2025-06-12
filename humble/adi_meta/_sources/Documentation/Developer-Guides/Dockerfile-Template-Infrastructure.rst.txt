Dockerfile Template Infrastructure
================================================================================

This document explains the template-based infrastructure used to generate Docker
images for the ADI ROS2 repository. The system uses Jinja2 templates to maintain
consistency across multiple image variants and architectures while reducing
code duplication.

Overview
--------------------------------------------------------------------------------

The ADI ROS2 project uses a template system to generate Dockerfiles rather than
maintaining them manually. This approach provides several key benefits:

- **Consistency**: many Dockerfiles can be generated from shared templates and
  snippets
- **Maintainability**: Changes to common functionality only need to be made in
  one place
- **Scalability**: New image variants can be easily added through configuration
- **Automation**: CI/CD pipelines automatically build and publish images from
  generated Dockerfiles

Architecture
--------------------------------------------------------------------------------

The template infrastructure consists of four main components:

1. **Template Configuration** (``scripts/templates.yml``).
2. **Jinja2 Templates** (``template/`` directory).
3. **Generation Scripts** (``scripts/generate.py`` and ``scripts/build.py``).
4. **CI/CD Integration** (``.github/workflows/docker.yml``).

Template Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``scripts/templates.yml`` file defines all Docker image configurations.
It specifies:

- **Repository variants**: ``adi_ros2`` (standard Ubuntu) and ``adi_ros2-l4t``
  (NVIDIA Jetson)
- **Build targets**: ``base``, ``full``, and ``desktop`` stages
- **Platform architectures**: ``linux/amd64`` and ``linux/arm64``
- **Base images**: ROS official images or NVIDIA L4T images
- **ROS distributions**: Currently supports ``humble``

Example configuration:

.. code-block:: yaml

    adi_ros2:
      - name: humble-amd64
        ros_distro: humble
        arch: amd64
        targets:
          - target: base
            platforms: "linux/amd64"
          - target: full
            platforms: "linux/amd64"
          - target: desktop
            platforms: "linux/amd64"
        base_image: "ros"
        image_version: "humble-ros-base"
        libiio_tag: "libiio-v0"

Jinja2 Templates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Templates are located in the ``template/`` directory and use Jinja2 syntax for
dynamic content generation.

**Main Templates:**

- ``adi_ros2.dockerfile.jinja``: Standard Ubuntu-based images
- ``adi_ros2-l4t.dockerfile.jinja``: NVIDIA Jetson-specific images
- ``docker_readme.md.jinja``: Auto-generated documentation

**Template Snippets:**

The ``template/snippets/`` directory contains reusable components that can be
shared across multiple main templates.

- ``system_dependencies.jinja``: Common system packages
- ``source_builds.jinja``: Library compilation from source
- ``ros2_entrypoint.jinja``: ROS2 environment initialization

**Template Variables:**

Templates use variables from ``templates.yml``:

.. code-block:: jinja

    FROM {{ base_image }}:{{ image_version }} AS base

    # Install ROS2 packages for {{ ros_distro }}
    RUN apt-get install -y ros-{{ ros_distro }}-desktop

Multi-Stage Build Architecture
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All generated Dockerfiles use a multi-stage build approach:

**1. Base Stage**
  - Installs ADI ROS2 packages and core dependencies
  - Builds libiio and other libraries from source
  - Sets up the ADI ROS2 workspace overlay

**2. Full Stage**
  - Extends base with additional ROS2 packages
  - Includes navigation, SLAM, and robotics tools

**3. Desktop Stage**
  - Adds full ROS2 desktop environment
  - Includes GUI applications and visualization tools
  - Suitable for development workstations

Generation Scripts
--------------------------------------------------------------------------------

The infrastructure includes two main Python scripts:

Generate Script (``scripts/generate.py``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This script processes templates and creates the final Dockerfiles:

.. code-block:: bash

    ./scripts/generate.py

**Functions:**

- Reads configuration from ``templates.yml``
- Renders Jinja2 templates with configuration variables
- Outputs Dockerfiles to ``docker/`` subdirectories
- Updates documentation and CI configuration

**Generated Files:**

- ``docker/adi_ros2/humble-amd64.Dockerfile``
- ``docker/adi_ros2/humble-arm64.Dockerfile``
- ``docker/adi_ros2-l4t/humble-l4t_r36.2.0.Dockerfile``
- ``docker/README.md`` (updates list with configuration of each Image Variant)
- ``.github/workflows/docker.yml`` (CI/CD matrix configuration updates)

Build Script (``scripts/build.py``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This script provides a convenient interface for building and testing images
locally:

.. code-block:: bash

    ./scripts/build.py [OPTIONS] IMAGE_NAME

**Key Options:**

- ``--generate``: Regenerate Dockerfiles from templates before building
- ``--no-push``: Skip pushing to registry (for local testing)
- ``--no-clean``: Keep intermediate containers for debugging
- ``--target``: Specify build stage (``base``, ``full``, or ``desktop``)

**Example Usage:**

.. code-block:: bash

    # Test template changes locally
    ./scripts/build.py --generate --no-push --target base humble-amd64

    # Build and push production image
    ./scripts/build.py --target desktop humble-arm64

CI/CD Integration
--------------------------------------------------------------------------------

The ``.github/workflows/docker.yml`` file automates the build and deployment process:

**Trigger Conditions:**
  - Pushes to ``humble*``, ``jazzy*``, or ``rolling*`` branches
  - Pull requests (build only, no push)
  - Manual workflow dispatch

**Build Matrix:**
  - Multiple architecture runners (``ubuntu-latest`` for AMD64, ``ubuntu-24.04-arm`` for ARM64)
  - Parallel builds for all target combinations
  - Separate jobs for different platforms

.. note:: **Matrix Synchronization:**

    The CI build matrix is automatically updated by the generation script
    (``scripts/generate.py``) based on the configuration in ``templates.yml``.
    When template configurations are modified (adding new image variants,
    architectures, or build targets), running the generate script will update the
    matrix stages in ``.github/workflows/docker.yml`` accordingly. This ensures
    that CI automatically builds all configured image variants without requiring
    manual updates to the workflow file.

**Image Tagging Strategy:**

.. code-block:: text

    analog/adi_ros2:humble-amd64-base
    analog/adi_ros2:humble-amd64-<commit-sha>
    analog/adi_ros2:humble-amd64-base-<date>

Development Workflow
--------------------------------------------------------------------------------

Adding New Image Variants
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **Update Configuration**: Add new entries to ``scripts/templates.yml``

.. code-block:: yaml

    adi_ros2:
      - name: rolling-amd64
        ros_distro: rolling
        arch: amd64
        # ... additional configuration

2. **Test Generation**: Run the generation script to verify templates

.. code-block:: bash

    ./scripts/generate.py

3. **Local Testing**: Build and test the new variant

.. code-block:: bash

    ./scripts/build.py --generate --no-push rolling-amd64

4. **Commit Changes**: Include both configuration and generated files

Modifying Templates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **Edit Templates**: Modify files in ``template/`` directory
2. **Regenerate Dockerfiles**: Update all generated files

.. code-block:: bash

    ./scripts/generate.py

3. **Test Changes**: Build affected images locally

.. code-block:: bash

    ./scripts/build.py --generate --no-push --target base humble-amd64

4. **Validation**: Ensure generated Dockerfiles are syntactically correct

Template Best Practices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Variable Naming:**
  - Use descriptive names matching ``templates.yml`` keys
  - Follow ``snake_case`` convention
  - Include validation for required variables

**Snippet Organization:**
  - Keep snippets focused on single concerns
  - Use descriptive filenames

**Conditional Logic:**
  - Use Jinja2 conditionals for platform-specific content
  - Keep conditional blocks minimal and readable
  - Document complex conditional logic

Troubleshooting
--------------------------------------------------------------------------------

Common Issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Template Syntax Errors:**
  - Verify Jinja2 syntax with ``scripts/generate.py``
  - Check variable names match ``templates.yml``
  - Ensure proper escaping of special characters

**Build Failures:**
  - Review generated Dockerfiles for syntax errors
  - Check base image availability
  - Verify package names and versions

**Missing Dependencies:**
  - Ensure Python requirements are installed: ``pip install -r scripts/requirements.txt``
  - Verify Docker and buildx are properly installed and configured
  - Check network connectivity for base image pulls


Maintenance Guidelines
--------------------------------------------------------------------------------

**Regular Updates:**

- Keep base images current with latest security patches.
- Keep the ``docker/adi_ros2-{ros_distro}.yml`` file updated with the latest
  ROS2 package versions and dependencies.
- Review and update system dependencies periodically.

**Version Management:**

- Tag template changes with meaningful commit messages.

**Documentation:**

- Update this documentation when adding new features.
- Document breaking changes in template syntax.

**Testing:**

- After modifying templates, always regenerate and check that all
  Dockerfiles are still valid and can be built.
- Verify builds succeed for all supported platforms.
- Validate image functionality with actual ROS2 workloads.
