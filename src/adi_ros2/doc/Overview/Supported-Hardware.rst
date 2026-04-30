.. _supported-hardware:

Supported Hardware
================================================================================

Supported hardware for each ADI Robotics SDK package. Links point to the
package documentation and to the product page on the
`Analog Devices catalog <https://www.analog.com/en/products.html>`_.

.. contents:: Table of Contents
   :depth: 2
   :local:


Motor Controllers
--------------------------------------------------------------------------------

``tmcl_ros2`` — TMCL over CAN (SocketCAN):

.. list-table::
   :header-rows: 1
   :widths: 42 33 25

   * - Device
     - Package
     - Catalog

   * - TMCM-343
     - `tmcl_ros2 docs`_
     - `TMCM-343 <https://www.analog.com/en/products/tmcm-343.html>`__

   * - TMCM-351
     - `tmcl_ros2 docs`_
     - `TMCM-351 <https://www.analog.com/en/products/tmcm-351.html>`__

   * - TMCM-0930
     - `tmcl_ros2 docs`_
     - `TMCM-0930 <https://www.analog.com/en/products/tmcm-0930.html>`__

   * - TMCM-1140 / PD-1140
     - `tmcl_ros2 docs`_
     - `TMCM-1140 <https://www.analog.com/en/products/tmcm-1140.html>`__

   * - TMCM-1160 / PD-1160
     - `tmcl_ros2 docs`_
     - `TMCM-1160 <https://www.analog.com/en/products/tmcm-1160.html>`__

   * - TMCM-1180 / PD-1180
     - `tmcl_ros2 docs`_
     - `TMCM-1180 <https://www.analog.com/en/products/tmcm-1180.html>`__

   * - TMCM-1230 / TMCM-1231 / TMCM-1240
     - `tmcl_ros2 docs`_
     - `TMCM-1230 <https://www.analog.com/en/products/tmcm-1230.html>`__

   * - TMCM-1241 / PD-1241
     - `tmcl_ros2 docs`_
     - `TMCM-1241 <https://www.analog.com/en/products/tmcm-1241.html>`__

   * - TMCM-1260 / PD-1260
     - `tmcl_ros2 docs`_
     - `TMCM-1260 <https://www.analog.com/en/products/tmcm-1260.html>`__

   * - TMCM-1270 / PD-1270
     - `tmcl_ros2 docs`_
     - `TMCM-1270 <https://www.analog.com/en/products/tmcm-1270.html>`__

   * - TMCM-1276 / PD-1276
     - `tmcl_ros2 docs`_
     - `TMCM-1276 <https://www.analog.com/en/products/tmcm-1276.html>`__

   * - TMCM-1278 / PD-1278
     - `tmcl_ros2 docs`_
     - `TMCM-1278 <https://www.analog.com/en/products/tmcm-1278.html>`__

   * - TMCM-1311 / TMCM-1316
     - `tmcl_ros2 docs`_
     - `TMCM-1311 <https://www.analog.com/en/products/tmcm-1311.html>`__

   * - TMCM-1617 / PD-1378 / PD-1670
     - `tmcl_ros2 docs`_
     - `TMCM-1617 <https://www.analog.com/en/products/tmcm-1617.html>`__

   * - TMCM-1633 / TMCM-1637 / TMCM-1638
     - `tmcl_ros2 docs`_
     - `TMCM-1633 <https://www.analog.com/en/products/tmcm-1633.html>`__

   * - TMCM-1636
     - `tmcl_ros2 docs`_
     - `TMCM-1636 <https://www.analog.com/en/products/tmcm-1636.html>`__

   * - TMCM-1690
     - `tmcl_ros2 docs`_
     - `TMCM-1690 <https://www.analog.com/en/products/tmcm-1690.html>`__

   * - TMCM-2611
     - `tmcl_ros2 docs`_
     - `TMCM-2611 <https://www.analog.com/en/products/tmcm-2611.html>`__

   * - TMCM-3110 / TMCM-3212 / TMCM-3230 / TMCM-3351
     - `tmcl_ros2 docs`_
     - `TMCM-3110 <https://www.analog.com/en/products/tmcm-3110.html>`__

   * - TMCM-6110 / TMCM-6212 / TMCM-6214
     - `tmcl_ros2 docs`_
     - `TMCM-6110 <https://www.analog.com/en/products/tmcm-6110.html>`__

``adi_tmc_coe_ros2`` — CANopen-over-EtherCAT (CoE):

.. list-table::
   :header-rows: 1
   :widths: 42 33 25

   * - Device
     - Package
     - Catalog

   * - TMCM-1461-CoE
     - `adi_tmc_coe_ros2 docs`_
     - `TMCM-1461 <https://www.analog.com/en/products/tmcm-1461.html>`__

   * - PD-1461
     - `adi_tmc_coe_ros2 docs`_
     - `PD-1461 <https://www.analog.com/en/products/pd-1461.html>`__


Sensor Drivers
--------------------------------------------------------------------------------

IIO Sensors
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``adi_iio`` package works with any ADI device exposed through the Linux
`IIO <https://www.kernel.org/doc/html/latest/driver-api/iio/index.html>`_ or
`hwmon <https://www.kernel.org/doc/html/latest/hwmon/index.html>`_ subsystems.
No specific hardware list is provided — if the device has a Linux IIO or hwmon
driver, ``adi_iio`` can interface with it. See the `iio_ros2 docs`_ for usage.


IMU
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
   :header-rows: 1
   :widths: 32 38 30

   * - Device
     - Package
     - Catalog

   * - ADIS16465
     - `imu_ros2 docs`_
     - `ADIS16465 <https://www.analog.com/en/products/adis16465.html>`__

   * - ADIS16467
     - `imu_ros2 docs`_
     - `ADIS16467 <https://www.analog.com/en/products/adis16467.html>`__

   * - ADIS16470
     - `imu_ros2 docs`_ · `adrd2121_imu_ros2 docs`_
     - `ADIS16470 <https://www.analog.com/en/products/adis16470.html>`__

   * - ADIS16475
     - `imu_ros2 docs`_
     - `ADIS16475 <https://www.analog.com/en/products/adis16475.html>`__

   * - ADIS16477
     - `imu_ros2 docs`_
     - `ADIS16477 <https://www.analog.com/en/products/adis16477.html>`__

   * - ADIS16500
     - `imu_ros2 docs`_ · `adrd2121_imu_ros2 docs`_
     - `ADIS16500 <https://www.analog.com/en/products/adis16500.html>`__

   * - ADIS16501
     - `imu_ros2 docs`_
     - `ADIS16501 <https://www.analog.com/en/products/adis16501.html>`__

   * - ADIS16505
     - `imu_ros2 docs`_
     - `ADIS16505 <https://www.analog.com/en/products/adis16505.html>`__

   * - ADIS16507
     - `imu_ros2 docs`_
     - `ADIS16507 <https://www.analog.com/en/products/adis16507.html>`__

   * - ADIS16545
     - `imu_ros2 docs`_
     - `ADIS16545 <https://www.analog.com/en/products/adis16545.html>`__

   * - ADIS16547
     - `imu_ros2 docs`_
     - `ADIS16547 <https://www.analog.com/en/products/adis16547.html>`__

   * - ADIS16575
     - `imu_ros2 docs`_
     - `ADIS16575 <https://www.analog.com/en/products/adis16575.html>`__

   * - ADIS16576
     - `imu_ros2 docs`_
     - `ADIS16576 <https://www.analog.com/en/products/adis16576.html>`__

   * - EVAL-ADISIMU1-RPIZ
     - `imu_ros2 docs`_
     - `EVAL-ADISIMU1-RPIZ <https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/eval-adisimu1-rpiz.html>`__

   * - EVAL-ADRD2121-EBZ
     - `adrd2121_imu_ros2 docs`_
     - `EVAL-ADRD2121-EBZ <https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/eval-adrd2121-ebz.html>`__


3D Time-of-Flight
--------------------------------------------------------------------------------

.. note::
   ``adi_3dtof_adtf31xx`` (sensor driver) builds on all platforms.
   ``adi_3dtof_floor_detector`` and ``adi_3dtof_safety_bubble_detector``
   (algorithm packages) are **amd64 only** — excluded from arm64 and Jetson builds.

.. list-table::
   :header-rows: 1
   :widths: 30 48 22

   * - Device
     - Packages
     - Catalog

   * - EVAL-ADTF3175D-NXZ
     - `adi_3dtof_adtf31xx docs`_ · `adi_3dtof_floor_detector docs`_ · `adi_3dtof_safety_bubble_detector docs`_
     - `EVAL-ADTF3175D-NXZ <https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/eval-adtf3175.html>`__

   * - ADSD3100
     - `adi_3dtof_adtf31xx docs`_ · `adi_3dtof_floor_detector docs`_ · `adi_3dtof_safety_bubble_detector docs`_
     - `ADSD3100 <https://www.analog.com/en/products/adsd3100.html>`__

   * - ADSD3030
     - `adi_3dtof_adtf31xx docs`_ · `adi_3dtof_floor_detector docs`_ · `adi_3dtof_safety_bubble_detector docs`_
     - `ADSD3030 <https://www.analog.com/en/products/adsd3030.html>`__


.. Package documentation links (relative to this page's output location)
.. _iio_ros2 docs: ../../adi_iio/index.html#http://
.. _imu_ros2 docs: ../../adi_imu/index.html#http://
.. _adrd2121_imu_ros2 docs: ../../adrd2121_imu/index.html#http://
.. _tmcl_ros2 docs: ../../adi_tmcl/index.html#http://
.. _adi_tmc_coe_ros2 docs: ../../adi_tmc_coe_core/index.html#http://
.. _adi_3dtof_adtf31xx docs: ../../adi_3dtof_adtf31xx/index.html#http://
.. _adi_3dtof_floor_detector docs: ../../adi_3dtof_floor_detector/index.html#http://
.. _adi_3dtof_safety_bubble_detector docs: ../../adi_3dtof_safety_bubble_detector/index.html#http://
