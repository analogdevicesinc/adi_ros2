.. _first-demo:

First Demo
================================================================================

.. contents:: On This Page
   :depth: 2
   :local:

This walkthrough is a minimal validation flow: run ``adi_iio`` and confirm it
is running from another shell using standard ROS2 tools.


.. note::

    All commands in this guide are run from the cloned repository root.


1. Run the Node
--------------------------------------------------------------------------------

Build the ``base`` image as described in :ref:`quick-start`:

.. code-block:: bash

    docker compose -f compose.build.yml build core

Run the node:

.. code-block:: bash

    docker compose up adi_iio

When the node is up, logs should include entries like:

.. code-block:: text

    adi_iio-1  | [INFO] [1777558055.460714243] [adi_iio_node]: creating context 0x56750e3c37b0 from uri ip:192.168.2.1
    adi_iio-1  | [INFO] [1777558055.461022389] [adi_iio_node]: setting timeout to 0
    adi_iio-1  | [INFO] [1777558055.462350528] [rclcpp]: Initializing buffers...
    adi_iio-1  | [INFO] [1777558055.467254907] [adi_iio_node]: IIO Node


2. Inspect from Another Shell
--------------------------------------------------------------------------------

Open another shell container:

.. code-block:: bash

    docker compose run --rm shell

From that shell, verify the node and services:

.. code-block:: bash

    ros2 node list
    ros2 service list
    ros2 service call /adi_iio_node/ListDevices adi_iio/srv/ListDevices

Expected: ``/adi_iio_node`` appears in ``ros2 node list`` and IIO services are
listed (for example ``/adi_iio_node/ListDevices``).

Example shell output:

.. code-block:: text

    root@docker-desktop:/# ros2 node list
    /adi_iio_node

    root@docker-desktop:/# ros2 service list
    /adi_iio_node/AttrDisableTopic
    /adi_iio_node/AttrEnableTopic
    /adi_iio_node/AttrReadString
    /adi_iio_node/AttrWriteString
    /adi_iio_node/BufferCreate
    /adi_iio_node/BufferDestroy
    /adi_iio_node/BufferDisableTopic
    /adi_iio_node/BufferEnableTopic
    /adi_iio_node/BufferRead
    /adi_iio_node/BufferRefill
    /adi_iio_node/BufferWrite
    /adi_iio_node/ListAttributes
    /adi_iio_node/ListChannels
    /adi_iio_node/ListDevices
    /adi_iio_node/ScanContext

    root@docker-desktop:/# ros2 service call /adi_iio_node/ListDevices adi_iio/srv/ListDevices
    requester: making request: adi_iio.srv.ListDevices_Request()

    response:
    adi_iio.srv.ListDevices_Response(success=True, message='Found 14 devices', data=['xadc', 'ad5625', 'm2k-fabric', 'm2k-adc-trigger', 'ad9963', 'm2k-adc', 'ad5627', 'pll', 'm2k-dds', 'm2k-dac-a', 'm2k-dac-b', 'm2k-logic-analyzer', 'm2k-logic-analyzer-tx', 'm2k-logic-analyzer-rx'])


Clean Up
--------------------------------------------------------------------------------

Stop the demo service:

.. code-block:: bash

    docker compose down