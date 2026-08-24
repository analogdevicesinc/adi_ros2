.. _prerequisites:

Prerequisites
================================================================================

This page lists what you need on your host machine to build and run ADI
Robotics SDK Docker images.

.. contents:: On This Page
   :depth: 2
   :local:


Why Docker?
--------------------------------------------------------------------------------

Each ROS2 distribution is tied to a specific Ubuntu release (e.g. Humble
requires Ubuntu 22.04). Docker removes this constraint — you can build and run
the ADI Robotics SDK on any host that supports Docker, regardless of the host
OS version.

Docker also packages all ADI-specific dependencies into reproducible images,
so you do **not** need a native ROS2 installation. Everything runs inside
containers.


System Requirements
--------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 25 75

   * - Resource
     - Requirement

   * - **Operating System**
     - Any Linux distribution, Windows 10/11 with WSL2, or macOS

   * - **Docker**
     - Docker Engine 24+ with Compose v2 plugin

   * - **Git**
     - Git 2.x (for cloning the repository and submodules)


Docker Engine
--------------------------------------------------------------------------------

Follow the official installation guide for your platform:

- `Install Docker Engine on Ubuntu`_
- `Install Docker Desktop for Windows`_ (WSL2 backend)
- `Install Docker Desktop for Mac`_

After installation on Linux, add your user to the ``docker`` group so you can
run Docker commands without ``sudo``:

.. code-block:: bash

    sudo usermod -aG docker $USER

Log out and back in (or run ``newgrp docker``) for the group change to take
effect.

Verify Docker is working:

.. code-block:: bash

    docker run hello-world

You should see ``Hello from Docker!`` in the output.

.. _Install Docker Engine on Ubuntu: https://docs.docker.com/engine/install/ubuntu/
.. _Install Docker Desktop for Windows: https://docs.docker.com/desktop/install/windows-install/
.. _Install Docker Desktop for Mac: https://docs.docker.com/desktop/install/mac-install/


Docker Compose (v2)
--------------------------------------------------------------------------------

Docker Compose v2 ships as a plugin with recent Docker Engine and Docker Desktop
installations. Verify it is available:

.. code-block:: bash

    docker compose version

.. warning::

   If the command is not found, your Docker installation may be outdated or
   incomplete.

   See the `Docker Compose install docs`_ for more information.

.. _Docker Compose install docs: https://docs.docker.com/compose/install/


Git
--------------------------------------------------------------------------------

.. code-block:: bash

    sudo apt install git

See the `Git installation guide`_ for other platforms.

.. _Git installation guide: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git


.. _verification-checklist:

Verification Checklist:
--------------------------------------------------------------------------------

Run each command and confirm the expected output:

.. code-block:: bash

    docker --version           # Docker version 24.x or newer
    docker compose version     # Docker Compose version v2.x
    docker run hello-world     # prints "Hello from Docker!"
    git --version              # git version 2.x

If all four checks pass, you are ready to proceed.
