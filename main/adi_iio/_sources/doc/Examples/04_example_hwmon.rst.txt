.. _example_hwmon:

================================================================================
HWMON
================================================================================

Prerequisites:

* A client running ROS2 with the ``adi_iio`` package installed.

.. note::

    This example demonstrates interaction with HWMON (Hardware Monitoring) devices.
    Please note that it is tailored for specific hardware
    (`Dell Precision 5530 2 in 1`_) and is intended to serve as a reference for
    understanding how to interact with HWMON devices in general. The example
    was tested with Ubuntu 22.04 and ROS2 Humble.


Example: ``dell_precision_5530.py``
================================================================================

Usage:
--------------------------------------------------------------------------------

To run the example, execute the following command in your terminal:

.. code-block:: shell

    ros2 launch hwmon dell_precision_5530.launch.py

When you execute the command, the ROS2 launch system will start the
``adi_iio`` node and the ``dell_precision_5530`` node example.


#.  **adi_iio_node**:

    *   **Package**: ``adi_iio``
    *   **Executable**: ``adi_iio_node``
    *   **Purpose**: Acts as a bridge to the Linux Industrial I/O (IIO)
        subsystem, enabling communication with connected hardware sensors.
    *   **Key Parameters**:

        * ``uri: "local:"``: Configures the node to use the local IIO context,
          meaning it will interface with IIO devices on the machine running the launch file.

#.  **dell_precision_5530_node**:

    *   **Package**: ``hwmon``
    *   **Executable**: ``dell_precision_5530``
    *   **Purpose**: Specifically designed to read and publish hardware
        monitoring (HWMON) data (like CPU temperatures, fan speeds, battery
        status) from a Dell Precision 5530 laptop. It relies on the
        ``adi_iio_node`` to access these hardware attributes.
    *   **Key Parameters**:

        *   ``loop_rate: 1``: Sets the main operational loop frequency.

Service Clients:
--------------------------------------------------------------------------------

The ``HWMon`` node uses two ROS 2 service clients on the ``/adi_iio_node``
provider:

- **AttrEnableTopic** (``/adi_iio_node/AttrEnableTopic``)

  This service tells the ``adi_iio_node`` to begin sampling a given IIO attribute
  and publishing it on a ROS 2 topic.

- **AttrDisableTopic** (``/adi_iio_node/AttrDisableTopic``)

  This service stops sampling and tears down the ROS 2 topic created earlier.

Topics:
--------------------------------------------------------------------------------

The ``HWMon`` node both subscribes to raw IIO‐driven topics and republishes
processed values:

Subscriptions (raw data from ``adi_iio_node``):
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: shell

    /BAT0/curr1/input/read
    std_msgs/String
    └─ Battery current in milliamps (mA).
        Transformed by `update_bat0_current`:
        μA = float(msg.data) * 1000.0

.. code-block:: shell

    /BAT0/in0/input/read
    std_msgs/String
    └─ Battery voltage in millivolts (mV).
        Transformed by `update_bat0_voltage`:
        V = float(msg.data) / 1000.0

.. code-block:: shell

    /coretemp/temp2/input/read … /coretemp/temp5/input/read
    std_msgs/String
    └─ CPU core temperature sensor readings in millivolts.
        Transformed by `update_coretemp_core*`:
        V = float(msg.data) / 1000.0

.. code-block:: shell

    /dell_smm/fan1/input/read
    std_msgs/String
    └─ CPU fan speed in RPM as a string.
        Transformed by `update_cpu_fan`:
        rpm = int(msg.data)

.. code-block:: shell

    /dell_smm/fan2/input/read
    std_msgs/String
    └─ GPU fan speed in RPM as a string.
        Transformed by `update_gpu_fan`:
        rpm = int(msg.data)

Publications (processed data):
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: shell

    /BAT0/uA
    std_msgs/Float64
    └─ Battery current in microamps (after conversion).

.. code-block:: shell

    /BAT0/V
    std_msgs/Float64
    └─ Battery voltage in volts (after conversion).

.. code-block:: shell

    /coretemp/core0 … /coretemp/core3
    std_msgs/Float64
    └─ Core temperatures expressed as voltages (V).

.. code-block:: shell

    /fan/cpu
    std_msgs/Int32
    └─ CPU fan speed in RPM.

.. code-block:: shell

    /fan/gpu
    std_msgs/Int32
    └─ GPU fan speed in RPM.


.. _Dell Precision 5530 2 in 1: https://www.dell.com/support/product-details/ro-ro/product/precision-15-5530-2-in-1-laptop/drivers
