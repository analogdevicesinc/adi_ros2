.. _node_description:

Node-Specific Concepts
================================================================================

This document provides a concise overview of the node-specific concepts for the
ROS2 package. It details the conventions for attribute paths, topic naming,
service responses, and buffer operations used when interfacing with IIO devices.

Channel and Device Attribute Path
--------------------------------------------------------------------------------

The ``attr_path`` parameter is used to specify the path to a specific attribute
within an IIO device. This path follows the structure of the IIO context hierarchy.

**Example:**

- An attribute path to a channel attribute might look like ``ad5592r/voltage0/raw``,
  where ``ad5592r`` is the device name, ``voltage0`` is the channel, and ``raw``
  is the attribute.
- A path to a device attribute would be ``ad9361-phy/calib_mode``.

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

A buffer represents continuous data capture from a device. The following operations
can be performed with IIO buffers:

- **Create buffer**: The device starts capturing data.
- **Refill buffer**: Data is transported from the device to the client via an
  ``Int32MultiArray`` in a service response.
- **Enable buffer topic**: The node initiates a continuous capture and publishes
  acquired data on the associated topic.
- **Destroy buffer**: The device stops capturing data.
- **Read buffer**: A convenience operation that bundles buffer creation and
  refill into one service call.

When creating a buffer, a channels array is required as a parameter for the
service request. For example:

- ``{"voltage0"}`` – for a single channel.
- ``{"voltage0", "voltage1", "voltage2", "voltage3"}`` – for multiple channels.

The data is bundled in an ``Int32MultiArray``. Data is interleaved in the buffer
such that the dimensions represent the number of samples and the number of channels.
For instance, a request that acquires data from channels ``{"voltage0", "voltage1"}``
would yield a buffer arranged as follows:

.. code-block::

    {voltage0_sample0, voltage1_sample0, voltage0_sample1, voltage1_sample1, voltage0_sample2, voltage1_sample2, ... }
