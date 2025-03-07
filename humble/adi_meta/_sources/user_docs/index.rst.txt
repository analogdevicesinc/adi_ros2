Analog Devices ROS2
================================================================================

Welcome to `Analog Devices Inc`_ ROS2 documentation!


.. toctree::
   :titlesonly:
   :maxdepth: 2
   :includehidden:

   Documentation


.. _repositories:

Repositories and Packages
================================================================================

Use this index to find the ROS2 packages you need provided by
`Analog Devices Inc`_ as well as examples on how to use them.


.. list-table::
  :header-rows: 1

  * - Repository Docs
    - Package Name
    - API Docs
    - Description

  * - `adi_ros2`_
    - ``adi_meta``
    - N/A
    - This package serves as a meta-package that aggregates all ROS2 packages
      provided by `Analog Devices Inc`_. It simplifies the installation
      process by providing a single package that depends on all individual
      ROS2 packages, ensuring that users can quickly and easily install the
      entire ADI suite.

  * - `iio_ros2`_
    - ``adi_iio``
    - `adi_iio API`_
    - This package interfaces with IIO devices, providing a comprehensive
      framework for integrating industrial I/O systems into modern robotics
      solutions. It offers services to read/write IIO attributes, manage IIO
      buffers, and attach topics to these attributes/buffers.

  * - `imu_ros2`_
    - ``adi_imu``
    - `adi_imu API`_
    - A package offering precision MEMS IMU integration with
      factory-calibrated gyroscopes and accelerometers, ensuring accurate
      motion data for robotics applications.

  * - `tmcl_ros2`_
    - ``adi_tmcl``
    - `adi_tmcl API`_
    - adi_tmcl (previously tmcl_ros2) is the official ROS2 Driver for ADI
      Trinamic Motor Controllers (TMC) that uses Trinamic Motion Control
      Language (TMCL) protocol.


.. _Analog Devices Inc: https://www.analog.com
.. _adi_ros2: ./index.html

.. _iio_ros2: ../adi_iio/index.html#http://
.. _adi_iio API: ../adi_iio/generated/index.html#http://

.. _imu_ros2: ../adi_imu/index.html#http://
.. _adi_imu API: ../adi_imu/generated/index.html#http://

.. _tmcl_ros2: ../adi_tmcl/index.html#http://
.. _adi_tmcl API: ../adi_tmcl/generated/index.html#http://
