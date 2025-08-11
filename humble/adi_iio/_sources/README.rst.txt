``adi_iio`` - ROS2 Package for IIO Integration
================================================================================

.. contents::
    :depth: 2

Overview
================================================================================

The ``adi_iio`` package bridges the gap between Analog Devices’ IIO hardware and
the ROS2 ecosystem. It provides robust, easy-to-integrate interfaces for sensor
data acquisition and real-time processing, enabling rapid development of advanced
robotics and automation applications.

By facilitating seamless communication and data exchange between IIO devices and
ROS2 nodes, the package serves as a comprehensive framework for integrating
industrial I/O systems into modern robotics solutions. It provides a collection
of services to read/write IIO attributes, and manage IIO buffers. You can also
attach topics to the attributes/buffers

This project is intended for both internal developers and external contributors
seeking to leverage Analog Devices’ IIO devices within ROS2 environments.


Getting Started
--------------------------------------------------------------------------------

To help you quickly get started with the ``adi_iio`` package, we have organized
detailed documentation into several sections:

* For information on **prerequisites, repository setup, and building the package**,
  refer to the `Installation`_ section.

* The :ref:`Examples Introduction` provides an overview of the available
  examples. Start with the :ref:`Service Call Reference` to use the ROS2
  services. You can also reference the standalone nodes and launch files for
  specific hardware interaction.

* For information on **parameters and services**, refer to the `Node Description`_ section.

* **System Tests:** The package includes comprehensive system tests located in the
  ``test/`` directory. These tests are integrated with ``colcon test`` and require
  specific hardware (Analog Devices IIO devices) to execute. Refer to the test
  directory's README for detailed setup instructions and execution guidelines.

* For building this documentation, refer to `Building the Project Documentation Locally`_.


Getting Help
--------------------------------------------------------------------------------

* **Issue Tracker:** Report bugs, request features, or submit technical queries
  via our `Issue Tracker`_.
* **Further Guidance:** For additional communication guidelines, refer to `COMMUNICATION`_.


Contributing
--------------------------------------------------------------------------------

Contributions are key to our project’s success. Before submitting changes:

* Familiarize yourself with our code and testing conventions.
* Consult the `CONTRIBUTING`_ for detailed instructions.
* Ensure your code adheres to our design values and guidelines.


License
--------------------------------------------------------------------------------

This project is licensed under the `Apache License, Version 2.0`_.

The product makes use of third party and open source software. The licenses and
notices for this software are listed at: `iio_ros2 - Third Party and Open Source Software`_.


CHANGELOG
--------------------------------------------------------------------------------

Refer to our `CHANGELOG`_ for version history and release notes.


.. _Installation:

Installation
================================================================================

This section describes how to install the required software to run the ``adi_iio``
package.


Prerequisites:
--------------------------------------------------------------------------------

Before installing the ``adi_iio`` package, ensure you have the following:

* A compatible version of ROS2 installed (e.g., ``humble``). See the `ROS2 Humble Installation Guide`_
  for instructions.
* The ``libiio v0`` library installed in the Host (e.g.: x86_64 host running Ubuntu 22.04)
  as well as the target (e.g.: Raspberry Pi 4). It can be automatically installed via ``rosdep``
  in systems where ROS2 is installed. Alternatively, you can build a specific
  version of it from source using the provided installation script
  (see `(Optional) Build libiio from sources`_).


Build from Source
--------------------------------------------------------------------------------

Source your main ROS2 environment as the underlay (in this example, ROS2 ``humble``):

.. code-block:: bash

    source /opt/ros/humble/setup.sh


Workspace Setup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you are not using this node in an existing project, create a new folder ``ros2_ws``,
then create the ``src`` folder in ``ros2_ws``. Go to src folder (either in
ros2_ws or in your project), and clone the adi_iio repository (make sure to clone the
correct branch for your ROS2 version):

.. code-block:: bash

    export COLCON_WS=~/ros2_ws
    mkdir -p $COLCON_WS/src
    cd $COLCON_WS/src
    git clone --branch humble https://github.com/analogdevicesinc/iio_ros2.git

.. tip::

    After cloning, your directory structure should look like this:

    .. code-block:: bash

        ros2_ws/
        └── src/
            └── iio_ros2/


Resolving Dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Before building the workspace, you need to resolve the package dependencies.
From the root of your workspace, run the following command:

.. code-block:: bash

    cd $COLCON_WS
    rosdep update
    rosdep install -i --from-path src --rosdistro ${ROS_DISTRO} -y --ignore-src


.. tip::

    If you already have all your dependencies, the console will return:

    .. code-block:: bash

        #All required rosdeps installed successfully

.. _(Optional) Build libiio from sources:

.. note::

    **Optional: Build Libiio from Source**

    The `adi_iio` package supports an alternative method of installing the libiio dependency
    by building it from source. This is useful if you prefer to use a custom version
    of libiio instead of relying on the system-provided ``libiio-dev`` package via rosdep.

    To build libiio from source, run the provided installation script which offers two options:

    - Set the desired libiio version (default is ``libiio-v0``).
    - Specify the staging directory for the source build (default is ``$HOME/src``).

    For example:

    .. code-block:: bash

        # Optional exports
        export LIBIIO_VERSION=libiio-v0
        export STAGING_DIR=$HOME/src

        cd ${COLCON_WS}/src/iio_ros2
        ./ci/install_dependencies.sh

    After the script completes, install the remaining package dependencies while skipping the
    system's libiio development package:

    .. code-block:: bash

        cd ${COLCON_WS}
        rosdep install --from-paths src --ignore-src -r -y --skip-keys libiio-dev


Building the Workspace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can now build your package using the command:

.. code-block:: bash

    colcon build --event-handlers console_cohesion+

Then source the previously built overlay run:

.. code-block:: bash

    source install/setup.sh

Now you can run the ``adi_iio`` package.


.. _node_specific_concepts:

``adi_iio`` - Node-Specific Concepts
================================================================================

This section provides a concise overview of the node-specific concepts for the
ROS2 package. It details the conventions for attribute paths, topic naming,
service responses, and buffer operations used when interfacing with IIO devices.

.. _iio_path:

IIO Path
--------------------------------------------------------------------------------

Services use the ``iio_path`` parameter to uniquely identify Industrial I/O
(IIO) devices, channels, and attributes following the IIO context hierarchy.
The ``/`` character is used to separate different levels of the hierarchy.

.. _Context Path:

Context Path
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Description:** an empty string is used to represent an IIO context.
- **Format:** ``""`` (empty string.)

.. _Context Attribute Path:

Context Attribute Path (``attr_path``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Description:** this path represents an attribute of a context.
- **Format:** ``<context-attribute>``
- **Example:** ``uri``, ``hw_vendor``, ``hw_serial``, etc.

.. _Device Path:

Device Path (``device_path``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Description:** this path represents a device of a context.
- **Format:** ``<device-name>``
- **Example:** ``ad9361-phy``, ``ad5592r``, etc.

.. _Device Attribute Path:

Device Attribute Path (``attr_path``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Description:** this path represents an attribute of a device.
- **Format:** ``<device-name>/<device-attribute>``
- **Example:** ``xadc/sampling_frequency``, etc.

.. _Channel Path:

Channel Path (``channel_path``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Description:** this path represents a channel of a device.
- **Format:** ``<device-name>/<channel-name>``
- **Example:** ``ad5592r/input_voltage0``, ``ad5592r/output_voltage0``,
  ``ad9361-phy/voltage0``, etc.
- **Note:** the channel name has an extended format which uses a prefix:
  ``input_`` or ``output_`` to indicate the direction of data flow for channels
  that share the same name. For example, ``ad5592r/input_voltage0`` and
  ``ad5592r/output_voltage0`` are both valid paths that refer to two different
  channels of the same device. When the prefix is not used (e.g:
  ``ad5592r/voltage0``) but the device has both input and output channels, the
  input channel has priority.

.. _Channel Attribute Path:

Channel Attribute Path (``attr_path``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Description:** this path represents an attribute of a channel.
- **Format:** ``<device-name>/<channel-name>/<channel-attribute>``
- **Example:** ``ad5592r/input_voltage0/scale``, ``ad5592r/output_voltage0/scale``,
  ``/cf-ad9361-lpc/voltage0/sampling_frequency``, etc.


.. _topic_name_resolution:

Topic Name Resolution
--------------------------------------------------------------------------------

The ``EnableTopic`` services can take an optional ``topic_name`` parameter. When
enabling the topic, the provided ``topic_name`` will be used. The default value
for this parameter is ``""``. When this default is used, the specific device/channel
attribute name is prefixed with the node name. For topics that deal with attributes,
two topics will be created for read and write operations. These topics are suffixed
with ``/read`` and ``/write``. To adhere to ROS2 topic naming standards, the
hyphen ``-`` is replaced by an underscore ``_``.

**Example:**

- An adi-iio node named ``radio`` that enables the topic
  ``/cf-ad9361-lpc/voltage0/sampling_frequency`` will publish to
  ``/radio/cf_ad9361_lpc/voltage0/sampling_frequency/read`` and subscribe to
  ``/radio/cf_ad9361_lpc/voltage0/sampling_frequency/write`` for updates.


.. _service_responses:

Service Responses
--------------------------------------------------------------------------------

All service responses contain at least two fields: a boolean indicating success
and a string message.

.. code-block::

    AttrReadString.srv:

    string attr_path
    ---
    bool success
    string message

If the service operation is successful, the success boolean is set to ``true``
and the message will be "Success". In case of failure, the success boolean is
set to ``false``, and the message contains the errno returned by the IIO command
along with its string interpretation.

Buffers
--------------------------------------------------------------------------------

A buffer represents continuous data capture from a device. Operations that can
be performed on buffers involve acquiring data from the device (``read``) and
sending data to the device (``write``).

The following operations can be performed with IIO buffers:

- **Create buffer**: Initializes a buffer for a specific device. For input
  devices, it starts hardware data acquisition on the selected channels.
- **Destroy buffer**: Stops buffer operations on a device and releases
  associated resources.
- **Refill buffer**: Data is transported from the hardware device to the client
  via an ``Int32MultiArray`` in a service response.
- **Read buffer**: A convenience operation that bundles destroy, input buffer
  creation and refill into one service call. The operation ensures that the
  buffer contains the latest samples captured from the device, rather than
  potentially stale data from previous operations.
- **Buffer Write**: A convenience operation that combines buffer destruction,
  output buffer creation and data transmission in a single service call. It
  pushes sample data from the node to the hardware device. In cyclic mode, the
  samples repeat in a loop.
- **Enable buffer topic**: The node initiates a continuous capture and
  publishes acquired data on the associated topic.
- **Disable buffer topic**: The node stops the continuous transfer of data to
  the buffer topic.

When creating a buffer, a channels array is required as a parameter for the
service request. For example:

- ``{"voltage0"}`` – for a single channel.
- ``{"voltage0", "voltage1", "voltage2", "voltage3"}`` – for multiple channels.

The data is bundled in an ``Int32MultiArray``. Data is interleaved in the buffer
such that the dimensions represent the number of samples and the number of channels.
For instance, a request that acquires data from channels ``{"voltage0", "voltage1"}``
would yield a buffer arranged as follows:

.. code-block:: shell

    {voltage0_sample0, voltage1_sample0, voltage0_sample1, voltage1_sample1, voltage0_sample2, voltage1_sample2, ... }


.. _Node Description:

``adi_iio`` - Node Description
================================================================================


.. _parameters:

Parameters
--------------------------------------------------------------------------------

The node accepts the following parameters:

* ``uri``: The URI of the LibIIO context where the device is connected to
  (e.g.: ``ip:192.168.2.1``).
* ``timeout``: A positive integer representing the time in milliseconds after
  which a timeout occurs. A value of 0 means no timeout.

.. _services:

Services
--------------------------------------------------------------------------------

The node provides the following services:

.. _AttrDisableTopic:

AttrDisableTopic
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Disables the topic associated with a specific attribute.

**Request:**

* ``attr_path`` (string): The path to the attribute to be disabled.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _AttrEnableTopic:

AttrEnableTopic
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Enables a topic for a specific attribute.

**Request:**

* ``attr_path`` (string): The path to the attribute for which a topic will be enabled.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _AttrReadString:

AttrReadString
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Reads an IIO attribute as a string.

**Request:**

* ``attr_path`` (string): The path to the attribute to be read.

**Response:**

* ``value`` (string): The value of the attribute.
* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _AttrWriteString:

AttrWriteString
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Writes an IIO attribute as a string

**Request:**

* ``attr_path`` (string): The path to the attribute to be written.
* ``value`` (string): The value to be written to the attribute.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _BufferCreate:

BufferCreate
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Creates a buffer.

**Request:**

* ``device_path`` (string): The path to the device.
* ``channels`` (string[]): The channels to be read from the buffer.
* ``samples_count`` (int32): The number of samples for the buffer.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _BufferDestroy:

BufferDestroy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Destroys a buffer.

**Request:**

* ``device_path`` (string): The path to the device.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _BufferDisableTopic:

BufferDisableTopic
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Disables a topic for a buffer.

**Request:**
* ``device_path`` (string): The path to the device.

**Response:**
* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _BufferEnableTopic:

BufferEnableTopic
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Enables a topic for a buffer.

**Request:**

* ``device_path`` (string): The path to the device.
* ``topic_name`` (string): The name of the topic to be enabled.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _BufferRead:

BufferRead
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Reads data from a buffer.

**Request:**

* ``device_path`` (string): The path to the device.
* ``channels`` (string[]): The channels to be read from the buffer.
* ``samples_count`` (int32): The number of samples to read.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.
* ``buffer`` (Int32MultiArray): The data read from the buffer.

.. _BufferRefill:

BufferRefill
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Refills a buffer.

**Request:**

* ``device_path`` (string): The path to the device.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.
* ``buffer`` (Int32MultiArray): The data read from the buffer after refilling.

.. _BufferWrite:

BufferWrite
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Writes data to a buffer.

**Request:**

* ``device_path`` (string): The path to the device.
* ``channels`` (string[]): The channels where data will be written.
* ``buffer`` (Int32MultiArray): The data to be written to the buffer.
* ``cyclic`` (bool): Indicates whether the buffer should be cyclic.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.

.. _ScanContext:

ScanContext
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Scans the  current IIO context and returns lists of devices,
channels, and attributes formatted as IIO paths which can be used as request
parameters for the other services.

**Request:**

* None. The operation uses the ``uri`` provided during node initialization to
  scan for devices.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.
* ``devices`` (string[]): A list of IIO paths to the discovered devices.
* ``channels`` (string[]): A list of IIO paths to the discovered channels.
* ``context_attrs`` (string[]): A list of IIO paths to the discovered context attributes.
* ``device_attrs`` (string[]): A list of IIO paths to the discovered device attributes.
* ``channel_attrs`` (string[]): A list of IIO paths to the discovered channel attributes.

.. _ListDevices:

ListDevices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Lists the IIO device paths found in the current context.

**Request:**

* None. The operation uses the ``uri`` provided during node initialization to
  scan for devices.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.
* ``data`` (string[]): A list containing the IIO device paths.

.. _ListChannels:

ListChannels
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Lists the IIO channel paths found in the targeted device.

**Request:**

* ``iio_path`` (string): The IIO path to the device to be scanned.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.
* ``data`` (string[]): A list containing the IIO channel paths.

.. _ListAttributes:

ListAttributes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Description:** Lists the IIO attribute paths found in the target path. This
can be either a context, device, or channel path.

**Request:**

* ``iio_path`` (string): The IIO path to a context,device or channel to be scanned.

**Response:**

* ``success`` (bool): Indicates whether the operation was successful.
* ``message`` (string): A message providing additional information.
* ``data`` (string[]): A list containing the IIO attribute paths.


.. _launch:

Launch
--------------------------------------------------------------------------------

To launch the node, you can use the provided launch file ``adi_iio_bringup.launch.py``.
You can start the node using the following command:

.. code-block:: shell

    ros2 launch adi_iio adi_iio_bringup.launch.py


.. tip::

  This launch file uses the the ``uri`` parameter defined in the
  ``config/adi_iio.yaml`` file. Your can either modify the file or pass the
  parameter directly in the command line when starting the node:

  .. code-block:: shell

    ros2 run adi_iio adi_iio_node --ros-args -p uri:="<your_uri>" --log-level debug


The project also contains a small python script to visualize the waveform using
matplotlib plots. The ``topic`` parameter is used to subscribe to the topic
where the waveform is published and plot the waveforms.

.. code-block:: bash

    python3 visualize_iio_waveform.py --topic /<your_topic_name>


.. note:: You can refer to the :ref:`demo_ad7124_8_visualize_waveform` to see
    the script in action.


.. _Building the Project Documentation Locally:

Building the Project Documentation Locally
================================================================================

This guide describes how to build the project documentation locally using
**rosdoc2**. Follow the steps below to set up your environment, build the
documentation, and view the results.


Prerequisites
--------------------------------------------------------------------------------

- **Python 3:** Ensure you have Python 3 installed.
- **Virtual Environment:** It is highly recommended to set up a Python virtual
  environment to avoid conflicts with other projects.
- **Dependencies:** All required dependencies are listed in ``doc/requirements.txt``.


Setting Up the Virtual Environment
--------------------------------------------------------------------------------

#. **Create the Virtual Environment**

   .. code-block:: bash

      python3 -m venv .venv

#. **Activate the Virtual Environment**

   .. code-block:: bash

      source .venv/bin/activate

#. **Install the Required Dependencies**

   .. code-block:: bash

      pip3 install -r doc/requirements.txt

#. **Source the Virtual Environment**

   .. code-block:: bash

      source .venv/bin/activate


Generate the Documentation
--------------------------------------------------------------------------------

With the environment set up, build the documentation by running the following script
which automatically install the required dependencies and build the documentation:

.. code-block:: bash

    cd ${COLCON_WS}/src/iio_ros2
    ./ci/build_doc.sh

You can now view the generated documentation by opening the ``_build/docs_output/adi_iio/index.html``
file in your web browser.



.. _Issue Tracker: https://github.com/analogdevicesinc/iio_ros2/issues
.. _COMMUNICATION: https://github.com/analogdevicesinc/iio_ros2/blob/humble/COMMUNICATION.md
.. _CONTRIBUTING: https://github.com/analogdevicesinc/iio_ros2/blob/humble/CONTRIBUTING.md
.. _Apache License, Version 2.0: https://github.com/analogdevicesinc/iio_ros2/blob/humble/LICENSE
.. _iio_ros2 - Third Party and Open Source Software: https://download.analog.com/iio_ros2/versions.html
.. _CHANGELOG: https://github.com/analogdevicesinc/iio_ros2/blob/humble/CHANGELOG.rst

.. _ROS2 Humble Installation Guide: https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html
