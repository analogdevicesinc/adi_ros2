.. _ci-infrastructure:

CI Infrastructure
================================================================================

.. contents:: On This Page
   :depth: 2
   :local:

All CI runs on GitHub Actions. Three workflows automate builds, documentation,
and submodule tracking.


Docker Build & Scan (``docker.yml``)
--------------------------------------------------------------------------------

**Triggers:** Push to ``**humble**`` or ``**ci**`` branches, all PRs, manual
dispatch.

**Job graph:** ``lint`` → ``build`` → ``scan``

**Lint**

Runs `hadolint <https://github.com/hadolint/hadolint>`_ on both
``docker/Dockerfile`` and ``docker/Dockerfile.l4t`` with failure threshold
``warning``.

**Build**

Builds all image stages using ``docker/bake-action`` with ``compose.build.yml``:

.. list-table::
   :header-rows: 1
   :widths: 15 25 40

   * - Arch
     - Runner
     - Targets
   * - amd64
     - ``ubuntu-latest``
     - core, base, full, desktop
   * - arm64
     - ``ubuntu-24.04-arm``
     - core, base, full, desktop
   * - arm64 (L4T)
     - ``ubuntu-24.04-arm``
     - l4t-core, l4t-base, l4t-full, l4t-desktop

Images are exported as zstd-compressed tarballs (1-day artifact retention).

**Scan**

Runs per image stage × architecture:

- **CVE scan**: Docker Scout, critical + high severity, fixed-only. SARIF
  results uploaded to GitHub Security tab.
- **SBOM**: SPDX format, 30-day artifact retention.

Concurrency: in-progress runs on the same branch are cancelled.


Documentation (``documentation.yml``)
--------------------------------------------------------------------------------

**Triggers:** Push to ``humble`` or ``doc-*`` branches, version tags
(``v*.*.*``), all PRs.

**Build job:**

1. Checkout with submodules
2. ``pip install -r src/adi_ros2/doc/requirements.txt``
3. Run ``ci/build_doc.sh`` (Sphinx via rosdoc2)
4. Upload HTML artifact

**Deploy job** (``humble`` branch only):

- Pushes built HTML to ``gh-pages`` branch
- Generates ``tags.json`` for versioned doc directories
- Creates redirect ``index.html`` at the root


Secrets & Permissions
--------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Secret
     - Used By
   * - ``GH_TOKEN``
     - Documentation deploy, submodule update PR creation
   * - ``DOCKERHUB_USERNAME``
     - Docker Scout CVE scan (requires Docker Hub login)
   * - ``DOCKERHUB_TOKEN``
     - Docker Scout CVE scan
   * - ``GITHUB_TOKEN``
     - SARIF upload to GitHub Security
