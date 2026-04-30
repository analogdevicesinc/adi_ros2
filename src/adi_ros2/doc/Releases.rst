.. _release-notes:

Release Notes
================================================================================

.. contents:: On This Page
   :depth: 1
   :local:


Change Log
--------------------------------------------------------------------------------

.. Reverse-chronological SDK-level changes: Docker infrastructure, CI,
   documentation, and submodule version bumps. Individual package changelogs
   are maintained in each package's own repository.

.. todo:: Populate with release entries as versions are tagged.


Known Issues
--------------------------------------------------------------------------------

1. The 3D ToF algorithm packages (``adi_3dtof_floor_detector``,
   ``adi_3dtof_safety_bubble_detector``) have unresolved dependencies on ARM64
   and are excluded from ``arm64`` and Jetson (L4T) builds.
   See :ref:`packages` for details.
