.. _packages:

Packages
================================================================================

The ADI Robotics SDK includes the following ROS2 packages. Each package lives
in its own repository and is linked here for its documentation and API reference.

.. note::
   The package manifest used during Docker builds is `docker/adi_ros2-humble.yml`.
   This file follows the `vcstool <https://github.com/dirk-thomas/vcstool>`_
   format and can be imported into any ROS2 workspace:

   .. code-block:: bash

      cd ~/ros2_ws/src
      vcs import --recursive < adi_ros2-humble.yml

   You can also extend it by adding your own repositories or pinning specific
   versions before importing.


Motor Controllers
--------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 15 15 12 43 15

   * - Repository
     - Package Name
     - API Docs
     - Description
     - ROS2 Distros

   * - `tmcl_ros2`_
     - ``adi_tmcl``
     - `adi_tmcl API`_
     - Official ROS2 driver for ADI Trinamic motor controllers (TMC) using
       the Trinamic Motion Control Language (TMCL) protocol over USB/UART.
     - Humble |check|

   * - `adi_tmc_coe_ros2`_
     - ``adi_tmc_coe`` / ``adi_tmc_coe_core`` / ``adi_tmc_coe_interfaces``
     - `adi_tmc_coe_core API`_
     - Official ROS2 metapackage for Trinamic motor controllers with
       CANopen-over-EtherCAT (CoE) interface.
     - Humble |check|


Sensor Drivers
--------------------------------------------------------------------------------

IIO Sensors
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
   :header-rows: 1
   :widths: 20 15 12 38 15

   * - Repository
     - Package Name
     - API Docs
     - Description
     - ROS2 Distros

   * - `iio_ros2`_
     - ``adi_iio``
     - `adi_iio API`_
     - ROS2 interface for `LibIIO`_-compatible ADI devices. Provides services to
       read and write IIO attributes, manage IIO buffers, and attach ROS2 topics
       to device channels. Compatible with any IIO-based ADI sensor.
     - Humble |check|


IMU
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
   :header-rows: 1
   :widths: 20 15 12 38 15

   * - Repository
     - Package Name
     - API Docs
     - Description
     - ROS2 Distros

   * - `imu_ros2`_
     - ``adi_imu``
     - `adi_imu API`_
     - Precision MEMS IMU driver for the ADIS16xxx family. Publishes
       ``sensor_msgs/Imu`` topics from factory-calibrated gyroscopes and
       accelerometers. Supports SPI and UART interfaces.
     - Humble |check|

   * - `adrd2121_imu_ros2`_
     - ``adrd2121_imu``
     - `adrd2121_imu API`_
     - High-speed asynchronous IMU sampling driver for the EVAL-ADRD2121-EBZ
       evaluation board. Supports ADIS16470 and ADIS16500 sensors. Adapted
       from the ROS1 ``adrd2121_imu_ros`` package.
     - Humble |check|


3D Time-of-Flight
--------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 15 15 12 43 15

   * - Repository
     - Package Name
     - API Docs
     - Description
     - ROS2 Distros

   * - `adi_3dtof_adtf31xx`_
     - ``adi_3dtof_adtf31xx``
     - `adi_3dtof_adtf31xx API`_
     - ROS2 driver for the ADTF3175D 3D Time-of-Flight sensor. Captures
       Depth and AB frames from the sensor and publishes them as ROS2 topics.
     - Humble |check|

   * - `adi_3dtof_floor_detector`_
     - ``adi_3dtof_floor_detector``
     - `adi_3dtof_floor_detector API`_
     - Floor detection algorithm using 3D ToF depth data. Segments each
       frame into floor and non-floor pixels. Used in robot navigation,
       autonomous driving, and obstacle avoidance. [#amd64_only]_
     - Humble |check| (amd64 only)

   * - `adi_3dtof_safety_bubble_detector`_
     - ``adi_3dtof_safety_bubble_detector``
     - `adi_3dtof_safety_bubble_detector API`_
     - Safety bubble detection algorithm for AGV/AMR applications. Monitors
       a configurable virtual zone around the robot and raises alerts when
       objects enter the zone, preventing collisions. [#amd64_only]_
     - Humble |check| (amd64 only)


.. rubric:: Footnotes

.. [#amd64_only] These algorithm packages have dependencies that cannot
   currently be resolved on ARM64 targets and are therefore excluded from
   ARM64 and NVIDIA Jetson (L4T) builds. The sensor driver
   (``adi_3dtof_adtf31xx``) is available on all platforms.


.. |check| unicode:: U+2705


.. External links
.. _iio_ros2: ../../adi_iio/index.html#http://
.. _adi_iio API: ../../adi_iio/generated/index.html#http://
.. _LibIIO: https://github.com/analogdevicesinc/libiio

.. _imu_ros2: ../../adi_imu/index.html#http://
.. _adi_imu API: ../../adi_imu/generated/index.html#http://

.. _adrd2121_imu_ros2: ../../adrd2121_imu/index.html#http://
.. _adrd2121_imu API: ../../adrd2121_imu/generated/index.html#http://

.. _tmcl_ros2: ../../adi_tmcl/index.html#http://
.. _adi_tmcl API: ../../adi_tmcl/generated/index.html#http://

.. _adi_tmc_coe_ros2: ../../adi_tmc_coe_core/index.html#http://
.. _adi_tmc_coe_core API: ../../adi_tmc_coe_core/generated/index.html#http://

.. _adi_3dtof_adtf31xx: ../../adi_3dtof_adtf31xx/index.html#http://
.. _adi_3dtof_adtf31xx API: ../../adi_3dtof_adtf31xx/generated/index.html#http://

.. _adi_3dtof_floor_detector: ../../adi_3dtof_floor_detector/index.html#http://
.. _adi_3dtof_floor_detector API: ../../adi_3dtof_floor_detector/generated/index.html#http://

.. _adi_3dtof_safety_bubble_detector: ../../adi_3dtof_safety_bubble_detector/index.html#http://
.. _adi_3dtof_safety_bubble_detector API: ../../adi_3dtof_safety_bubble_detector/generated/index.html#http://
