.. _building-documentation:

Building Documentation
================================================================================

.. contents:: On This Page
   :depth: 2
   :local:

Documentation is built with `rosdoc2 <https://github.com/ros-infrastructure/rosdoc2>`_
and `Sphinx <https://www.sphinx-doc.org/>`_, using the
`ADI Doctools <https://github.com/analogdevicesinc/doctools>`_ theme. CI builds
and deploys automatically on merge to ``humble``.


Setup
--------------------------------------------------------------------------------

.. code-block:: bash

   git submodule update --init --recursive

   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r src/adi_ros2/doc/requirements.txt


Full Build
--------------------------------------------------------------------------------

.. code-block:: bash

   ./ci/build_doc.sh

Output is written to ``_build/docs_output/``. Open locally with:

.. code-block:: bash

   xdg-open _build/docs_output/adi_meta/index.html


Single Package Build
--------------------------------------------------------------------------------

For faster iteration on one package:

.. code-block:: bash

   rosdoc2 build --package-path src/imu_ros2 --debug


Where to Edit
--------------------------------------------------------------------------------

- **Meta-repository docs** (``src/adi_ros2/doc/``): commit here. Add new
  ``.rst`` files to the relevant ``toctree`` directive.
- **Package docs** (``src/<package>/doc/``): edit in the submodule repo, merge
  to ``humble``, then update the submodule reference here.
