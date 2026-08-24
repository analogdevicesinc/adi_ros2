Frequently Asked Questions (FAQ)
================================================================================

General Questions
--------------------------------------------------------------------------------

Q1: What is the purpose of this ROS2 package?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``adi_iio_node`` is a ROS 2 node that interfaces with Analog Devices IIO devices.
It provides a collection of services to read/write IIO attributes, and manage
IIO buffers. You can also attach topics to the attributes/buffers

Q2: Which ROS2 distributions are supported?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The package currently supports the ROS2 distribution indicated as the base
branch in the repository (**e.g., humble**). Other supported distributions
may also be available in separate branches named after each distribution.
Please refer to the repository branches for detailed compatibility information.

Installation and Setup
--------------------------------------------------------------------------------

Q1: How do I install this package?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Instructions for installing the package can be found in the :ref:`installation` section.

Q2: How do I build the package with a custom libiio dependency?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The project includes a script that builds libiio from source. For more information,
refer to the :ref:`libiio_source_build` section.

Usage
--------------------------------------------------------------------------------

Q1: How do I launch the nodes and use the provided launch files?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The nodes can be launched using the provided launch files that are part of
this project. For detailed instructions on how to run the nodes, please refer
to the :ref:`launch` section.


.. note::
   This FAQ is a living document. Contributions to improve or update the FAQ are welcome.
