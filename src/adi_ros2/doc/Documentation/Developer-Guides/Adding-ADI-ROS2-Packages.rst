.. _Adding ADI ROS2 Packages:

Adding ADI ROS2 Packages
================================================================================

.. contents:: Table of Contents
  :depth: 2
  :local:


Introduction
--------------------------------------------------------------------------------

This guide outlines the dual process for adding a new Analog Devices ROS 2 package
to this meta-repository. The repository uses two parallel approaches for package
management:

1. **Git Submodules**: For documentation pipeline integration and development workflow
2. **VCS Import Lists**: For Docker image builds and distribution

Both approaches serve different purposes and both must be updated when adding new packages.

Overview of the Dual System
--------------------------------------------------------------------------------

Documentation Pipeline vs Docker Builds
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Git Submodules** are used for:

- Documentation generation with ``rosdoc2`` and ``adi_doctools``
- Developer workspace setup for local development
- Cross-referencing between packages in documentation

**VCS Import Lists** (like ``adi_ros2-humble.yml``) are used for:

- Docker container builds where specific package versions are needed
- Reproducible builds independent of submodule states
- Template-driven conditional building based on platform/architecture

Template System Integration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The repository uses a Jinja2-based template system (``scripts/templates.yml``) that allows:

- Conditional building based on platform (e.g., ``humble-amd64`` vs ``humble-l4t_r36.2.0``)
- Version-controlled dependencies (e.g., ``libiio_tag: "libiio-v0"``)
- Architecture-specific package inclusion/exclusion
- Multi-target Docker builds (``base``, ``full``, ``desktop``)

Adding a New Package
--------------------------------------------------------------------------------

Step 1: Add as Git Submodule (Documentation Pipeline)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#.  **Navigate to the src directory of the `adi_ros2` workspace:**

    .. code-block:: shell

        cd ~/adi_ros2/src # Or your equivalent adi_ros2 workspace

#.  **Add the submodule:**
    Replace `<repository_url>` with the URL of the new package's Git repository
    and `<path_to_submodule>` with the desired location within the `src/`
    directory (e.g., `src/new_adi_package`).

    .. code-block:: shell

        git submodule add <repository_url> <path_to_submodule>

        # Example
        git submodule add https://github.com/analogdevicesinc/iio_ros2.git src/iio_ros2

#.  **Initialize and update the submodule:**

    .. code-block:: shell

        git submodule update --init --recursive <path_to_submodule>

        # Example
        git submodule update --init --recursive src/iio_ros2

#.  **Commit the submodule addition:**

    .. code-block:: shell

        git add .gitmodules <path_to_submodule>
        git commit --signoff -m "Add <new_package_name> as a submodule"

.. note::
    You can build locally the documentation with the new package using the
    ``./ci/build_doc.sh`` script. Alternatively you can download the artifacts
    generated when you commit changes to the repository.

.. note::
   Submodules are primarily for documentation generation and development workflows.
   For Docker builds, you must also update the VCS import lists (Step 2).


Step 2: Add to VCS Import Lists (Docker Builds)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#.  **Update the VCS import file for your target ROS distribution:**

    Edit ``docker/adi_ros2-<ros_distro>.yml`` (e.g., ``docker/adi_ros2-humble.yml``):

    .. code-block:: yaml

        # docker/adi_ros2-humble.yml
        repositories:
          # ...existing packages...

          new_package_name:
            type: git
            url: https://github.com/analogdevicesinc/new_package_name.git
            version: main  # or specific branch/tag

    .. note::
       The VCS import system is separate from git submodules and allows specifying
       exact versions/branches for reproducible Docker builds.

    .. note::
        If the new package builds with standard ``rosdep`` and ``colcon``, then
        these are all the changes required.


Step 3: Update Template System (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#.  **Review scripts/templates.yml for version control:** define the branch/tag
    for the dependencies of the new package that need to be installed from sources.

    .. code-block:: yaml

        # scripts/templates.yml
        adi_ros2:
          - name: humble-amd64
            ros_distro: humble
            arch: amd64
            targets:
              - target: base
                platforms: "linux/amd64"
              - target: full
                platforms: "linux/amd64"
            # Version variables for source builds
            libiio_tag: "libiio-v0"
            new_dependency_source: "v1.0.0"

#.  **Update Jinja2 templates:**

    - ``template/snippets/source_builds.jinja`` - extend with build instructions
      for additional dependencies that need to be built from sources.
    - ``template/snippets/system_dependencies.jinja`` - for additional system
      dependencies that need to be installed on the target system.


Update Dockerfiles
--------------------------------------------------------------------------------

#.  **Test template generation:**
    Use the provided script to regenerate Dockerfiles and verify your changes:

    .. code-block:: shell

        cd scripts/
        python generate.py  # Regenerates Dockerfiles from templates

    .. note::
        Save the changes made to the Dockerfiles to a commit. Re-run the ``generate.py``
        and save the ``docker/README.md`` file in a separate commit to
        reference the versioned Dockerfiles in the repository.

#.  **For platform-specific builds:**
    If the new package requires different handling across platforms (amd64 vs
    arm64 vs L4T), ensure the template logic handles these differences
    correctly.


Push Changes and CI Validation
--------------------------------------------------------------------------------

Once everything is verified locally:

#.  **Commit and push all changes:**

#.  **Verify CI/CD pipeline:**
    Check that GitHub Actions workflows complete successfully, particularly:

    - Documentation generation workflow
    - Docker image builds (if configured)


Final Checklist
--------------------------------------------------------------------------------

- [ ] **Submodule Integration**

  - [ ] Submodule added and initialized correctly
  - [ ] ``.gitmodules`` file updated and committed
  - [ ] Submodule points to correct branch/commit

- [ ] **VCS Import Integration**

  - [ ] Package added to appropriate VCS import file (``docker/adi_ros2-<ros_distro>.yml``)
  - [ ] Correct repository URL and version specified
  - [ ] Platform-specific VCS files updated if needed
  - [ ] Local test with the ``make clone`` command within the ``docker/`` directory
    to ensure the package is cloned correctly

- [ ] **Template System**

  - [ ] Version variables added to ``scripts/templates.yml`` if needed
  - [ ] Conditional logic updated in Jinja2 templates if required
  - [ ] Template generation tested (``python scripts/generate.py``) and committed

- [ ] **Build Testing**

  - [ ] Docker local build is successful with the ``scripts/build.py`` script for
    a relevant target platform

- [ ] **Repository Updates**

  - [ ] All changes committed with proper sign-off
  - [ ] Changes pushed to feature branch
  - [ ] Pull request created with comprehensive description
