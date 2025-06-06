#  Overview: `/scripts`

This directory contains automation scripts for managing Docker containers and CI/CD workflows for the ADI ROS2 project.

## Overview

The scripts folder integrates with the repository by:
- Managing Docker image builds and deployments
- Generating Dockerfiles and CI workflows from templates
- Maintaining build configurations through YAML templates
- Automating container lifecycle management (build, tag, push, clean)

## Files

- **`build.py`** - Docker container build and management script
- **`generate.py`** - Template-based file generation for Dockerfiles and CI workflows
- **`templates.yml`** - Configuration file defining build targets and platforms

### Supporting Files

- **`requirements.txt`** - Python dependencies for the scripts, use during `.venv.` setup.

## Script Purposes

### build.py
**Purpose**: Local Docker container builds, tagging, and publishing utilities.
To b used it for local development only.

**Key Features**:
- Build Docker Image targets defined with the `templates.yml`.
- Support for multi-stage Docker builds (base, full, desktop targets).
- Push images to container registries.

**Usage**:
```bash
python build.py [OPTIONS] IMAGE

#
python build.py --help                    # Show detailed help
```

### generate.py
**Purpose**: uses information form `templates.yml` to generate Dockerfiles,
update CI workflows, and Docker Hub documentation from Jinja2 templates defined
in the `template` directory.


**Usage**:
```bash
python generate.py   # Run full generation pipeline

# Generates:
# - Dockerfiles in docker/ directory
# - GitHub Actions workflows in .github/workflows/
# - Docker README documentation
```

## Configuration

### templates.yml
Defines build configurations for different ROS2 Docker images:

- **Repository definitions**: `adi_ros2`, `adi_ros2-l4t`
- **Architecture support**: amd64, arm64, L4T (NVIDIA Jetson)
- **Build targets**: base, full, desktop
- **Platform specifications**: Linux architectures
- **Base image configurations**: ROS distributions, versions

## Integration with Repository

1. **Docker Integration**: Works with `docker/` directory for Dockerfile templates and build context
2. **CI/CD Integration**: Updates GitHub Actions workflows in `.github/workflows/`
3. **Template System**: Uses `template/` directory for Jinja2 templates
4. **Build Automation**: Integrates with repository's Docker build infrastructure

## Dependencies

Install required Python packages:

```bash
python -m venv .venv
source ./venv/bin/activate
pip install -r requirements.txt
```