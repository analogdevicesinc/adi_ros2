.. _Examples Introduction:

================================================================================
Examples Introduction
================================================================================

This Github Repository provides a set of demos to showcase the capabilities of the
``adi_iio`` ROS2 package and how you can use it to interface with various
Analog Devices IIO devices.

Setup
================================================================================

Before your can run the examples, you need to install the ``adi_iio`` package.
Please follow the instructions in the :ref:`Installation` section, under build
from source.

Build examples from Source
--------------------------------------------------------------------------------

* With the ``adi_iio`` package installed, you can build the examples from source
  by running the following commands in your terminal:


.. code-block:: shell

    export COLCON_WS=~/ros2_ws
    cd $COLCON_WS

    colcon build  \
        --symlink-install \
        --event-handlers console_cohesion+ \
        --base-paths ./src/iio_ros2/examples/

The previous command will build all the available examples in the
``adi_iio`` package. You can also build a specific example by specifying the
``--base-path`` of the example you want to build.


Examples Overview:
================================================================================

#. `Service call reference`_:

    This example demonstrates how to call the services exposed by the
    ``adi_iio`` node. It provides a reference for using the services to
    read/write IIO attributes and manage IIO buffers.

#. `AD5592R`_:

    This demo showcases the usage of the AD5592R device, which is an
    8-channel, 12-bit, configurable ADC/DAC with on-chip Reference using an SPI
    Interface.

#. `AD7124-8`_:

    This demo demonstrates the functionalities of the AD7124, a high-precision
    integrated ADC suitable for various industrial applications.

#. `HWMON`_:

    This demo illustrates how to interface with the hwmon subsystem to read
    temperature, current and voltage data from the system's sensors.


.. _Service call reference: ./01_service_call_reference.html
.. _AD5592R: ./02_example_ad5592r.html
.. _AD7124-8: ./03_example_ad7124-8.html
.. _HWMON: ./04_example_hwmon.html
