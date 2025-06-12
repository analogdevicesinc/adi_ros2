.. _Service Call Reference:

================================================================================
``adi_iio_node``: service call reference
================================================================================

Prerequisites:
================================================================================

The command below launches the adi_iio_node executable from the adi_iio package.
The ``uri`` parameter is used to describe the context location of the IIO device.

.. code-block:: shell

    URI=ip:192.168.2.1
    ros2 run adi_iio adi_iio_node \
        --ros-args \
        -p uri:=$URI \
        --log-level debug

From a new terminal you can view the names of all the running nodes:

.. code-block:: shell

    ros2 node list

The terminal should return the node name, which indicates it is running.

.. code-block:: shell

    /adi_iio_node

.. warning::

    The ``adi_iio_node`` executable must be running in order to use the services
    described below.

Overview:
================================================================================

#. Inspect node information:

    .. code-block:: shell

        ros2 node info /adi_iio_node

    You should see a list like this:

    .. code-block:: shell

        /adi_iio_node
            Subscribers:
                /parameter_events: rcl_interfaces/msg/ParameterEvent
            Publishers:
                /parameter_events: rcl_interfaces/msg/ParameterEvent
                /rosout: rcl_interfaces/msg/Log
            Service Servers:
                /adi_iio_node/AttrDisableTopic: adi_iio/srv/AttrDisableTopic
                /adi_iio_node/AttrEnableTopic: adi_iio/srv/AttrEnableTopic
                /adi_iio_node/AttrReadString: adi_iio/srv/AttrReadString
                /adi_iio_node/AttrWriteString: adi_iio/srv/AttrWriteString
                /adi_iio_node/BufferCreate: adi_iio/srv/BufferCreate
                /adi_iio_node/BufferDestroy: adi_iio/srv/BufferDestroy
                /adi_iio_node/BufferDisableTopic: adi_iio/srv/BufferDisableTopic
                /adi_iio_node/BufferEnableTopic: adi_iio/srv/BufferEnableTopic
                /adi_iio_node/BufferRead: adi_iio/srv/BufferRead
                /adi_iio_node/BufferRefill: adi_iio/srv/BufferRefill
                /adi_iio_node/BufferWrite: adi_iio/srv/BufferWrite
                /adi_iio_node/ListAttributes: adi_iio/srv/ListAttributes
                /adi_iio_node/ListChannels: adi_iio/srv/ListChannels
                /adi_iio_node/ListDevices: adi_iio/srv/ListDevices
                /adi_iio_node/ScanContext: adi_iio/srv/ScanContext
                /adi_iio_node/describe_parameters: rcl_interfaces/srv/DescribeParameters
                /adi_iio_node/get_parameter_types: rcl_interfaces/srv/GetParameterTypes
                /adi_iio_node/get_parameters: rcl_interfaces/srv/GetParameters
                /adi_iio_node/list_parameters: rcl_interfaces/srv/ListParameters
                /adi_iio_node/set_parameters: rcl_interfaces/srv/SetParameters
                /adi_iio_node/set_parameters_atomically: rcl_interfaces/srv/SetParametersAtomically
            Service Clients:

            Action Servers:

            Action Clients:

#. Inspect exposed services:


    Running the command :code:`ros2 service list --show-types` should return a list
    containing only the services currently available in the system along with their
    associated types:

    .. code-block:: shell

        /adi_iio_node/AttrDisableTopic [adi_iio/srv/AttrDisableTopic]
        /adi_iio_node/AttrEnableTopic [adi_iio/srv/AttrEnableTopic]
        /adi_iio_node/AttrReadString [adi_iio/srv/AttrReadString]
        /adi_iio_node/AttrWriteString [adi_iio/srv/AttrWriteString]
        /adi_iio_node/BufferCreate [adi_iio/srv/BufferCreate]
        /adi_iio_node/BufferDestroy [adi_iio/srv/BufferDestroy]
        /adi_iio_node/BufferDisableTopic [adi_iio/srv/BufferDisableTopic]
        /adi_iio_node/BufferEnableTopic [adi_iio/srv/BufferEnableTopic]
        /adi_iio_node/BufferRead [adi_iio/srv/BufferRead]
        /adi_iio_node/BufferRefill [adi_iio/srv/BufferRefill]
        /adi_iio_node/BufferWrite [adi_iio/srv/BufferWrite]
        /adi_iio_node/ListAttributes [adi_iio/srv/ListAttributes]
        ...


    You can inspect the interface of each service in order to find the request
    (above) and response (below) parameters. For example:

    .. code-block:: shell

        ros2 interface show adi_iio/srv/AttrWriteString

    Which will return the interface of the service:

    .. code-block:: shell

        string attr_path
        string value
        ---
        bool success
        string message


Service Call Reference:
================================================================================


ScanContext
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`ScanContext` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/ScanContext adi_iio/srv/ScanContext

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.ScanContext_Request()

    response:
    adi_iio.srv.ScanContext_Response(success=True, message='Found: Context attributes: 16; Devices: 14; Channels: 98; Device attributes: 54; Channel attributes: 372; ', devices=['xadc', 'ad5625', 'm2k-fabric', 'm2k-adc-trigger', 'ad9963', 'm2k-adc', 'ad5627', 'pll', 'm2k-dds', 'm2k-dac-a', 'm2k-dac-b', 'm2k-logic-analyzer', 'm2k-logic-analyzer-tx', 'm2k-logic-analyzer-rx'], channels=['xadc/input_voltage5', 'xadc/input_voltage0', 'xadc/input_voltage4', 'xadc/input_temp0', ....)

The response fields contain lists of :ref:`IIO Path` values.


ListDevices
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`ListDevices` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/ListDevices adi_iio/srv/ListDevices

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.ListDevices_Request()

    response:
    adi_iio.srv.ListDevices_Response(success=True, message='Found 14 devices', data=['xadc', 'ad5625', 'm2k-fabric', 'm2k-adc-trigger', 'ad9963', 'm2k-adc', 'ad5627', 'pll', 'm2k-dds', 'm2k-dac-a', 'm2k-dac-b', 'm2k-logic-analyzer', 'm2k-logic-analyzer-tx', 'm2k-logic-analyzer-rx'])

The ``data`` field from the response contains a list of ``device_paths`` as
described in the :ref:`Device Path` section.


ListChannels
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`ListChannels` service documentation.

**Usage:**

The request interface for this service requires the user to specify the
``iio_path`` using a valid :ref:`Device Path` value.

.. code-block:: shell

    ros2 service call /adi_iio_node/ListChannels adi_iio/srv/ListChannels "{
        iio_path: 'm2k-adc'
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.ListChannels_Request(iio_path='m2k-adc')

    response:
    adi_iio.srv.ListChannels_Response(success=True, message='Found 2 channels in device: m2k-adc', data=['m2k-adc/input_voltage0', 'm2k-adc/input_voltage1'])

The ``data`` field from the response contains a list of ``channel_paths`` as
described in the :ref:`Channel Path` section.


ListAttributes
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`ListAttributes` service documentation.

**Usage:**

The request interface for this service requires the user to specify the
``iio_path`` using a valid :ref:`Context Path`, :ref:`Device Path`, or
:ref:``Channel Path`` value.

**Context Path attributes:**

.. code-block:: shell

    ros2 service call /adi_iio_node/ListAttributes adi_iio/srv/ListAttributes "{
        iio_path: ''
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.ListAttributes_Request(iio_path='')

    response:
    adi_iio.srv.ListAttributes_Response(success=True, message='Found 16 attributes', data=['hw_model', 'hw_model_variant', 'hw_serial', 'fw_version', 'cal,offset_pos_dac', 'cal,gain_pos_dac', 'cal,offset_pos_adc', 'cal,gain_pos_adc', 'cal,offset_neg_dac', 'cal,gain_neg_dac', 'cal,offset_neg_adc', 'cal,gain_neg_adc', 'cal,temp_lut', 'local,kernel', 'uri', 'ip,ip-addr'])

The ``data`` field from the response contains a list of ``attr_path`` to
context attributes as described in the :ref:`Context Attribute Path` section.

**Device Path attributes:**

.. code-block:: shell

    ros2 service call /adi_iio_node/ListAttributes adi_iio/srv/ListAttributes "{
        iio_path: 'm2k-dac-a'
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.ListAttributes_Request(iio_path='m2k-dac-a')

    response:
    adi_iio.srv.ListAttributes_Response(success=True, message='Found 11 attributes in device: m2k-dac-a', data=['m2k-dac-a/auto_rearm_trigger', 'm2k-dac-a/calibscale', 'm2k-dac-a/dma_sync', 'm2k-dac-a/dma_sync_start', 'm2k-dac-a/oversampling_ratio', 'm2k-dac-a/sampling_frequency', 'm2k-dac-a/sampling_frequency_available', 'm2k-dac-a/trigger_condition', 'm2k-dac-a/trigger_condition_available', 'm2k-dac-a/trigger_src', 'm2k-dac-a/trigger_src_available'])

The ``data`` field from the response contains a list of ``attr_path`` to
device attributes as described in the :ref:`Device Attribute Path` section.


**Channel Path attributes:**

.. code-block:: shell

    ros2 service call /adi_iio_node/ListAttributes adi_iio/srv/ListAttributes "{
        iio_path: 'm2k-dac-a/output_voltage0'
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.ListAttributes_Request(iio_path='m2k-dac-a/output_voltage0')

    response:
    adi_iio.srv.ListAttributes_Response(success=True, message='Found 5 attributes in channel: output_voltage0', data=['m2k-dac-a/output_voltage0/raw', 'm2k-dac-a/output_voltage0/raw_enable', 'm2k-dac-a/output_voltage0/raw_enable_available', 'm2k-dac-a/output_voltage0/trigger_status', 'm2k-dac-a/output_voltage0/trigger_status_available'])

The ``data`` field from the response contains a list of ``attr_path`` to
channel attributes as described in the :ref:`Channel Attribute Path` section.


AttrEnableTopic
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`AttrEnableTopic` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/AttrEnableTopic adi_iio/srv/AttrEnableTopic "{
        attr_path: xadc/input_temp0/raw
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.AttrEnableTopic_Request(attr_path='xadc/input_temp0/raw', topic_name='', loop_rate=1, type=0)

    response:
    adi_iio.srv.AttrEnableTopic_Response(success=True, message='Success')


.. note::

    Running the command ``ros2 topic list`` should show the new topics created:
    ``/xadc/input_temp0/raw/read`` and ``/xadc/input_temp0/raw/write``. Since
    this example uses an input channel,  we can monitor the topic using the
    command ``ros2 topic echo /xadc/input_temp0/raw/read``.

.. note::

    **Control the data type of the topic:**

    .. code-block:: shell

        ros2 service call /adi_iio_node/AttrEnableTopic adi_iio/srv/AttrEnableTopic "{
            attr_path: xadc/input_temp0/raw,
            type: 1
        }"

    **Control the loop rate of the topic:**

    .. code-block:: shell

        ros2 service call /adi_iio_node/AttrEnableTopic adi_iio/srv/AttrEnableTopic "{
            attr_path: xadc/input_temp0/raw,
            loop_rate: 10
        }"


AttrDisableTopic
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`AttrDisableTopic` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/AttrDisableTopic adi_iio/srv/AttrDisableTopic "{
        topic_name: xadc/input_temp0/raw
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.AttrDisableTopic_Request(topic_name='xadc/input_temp0/raw', type=0)

    response:
    adi_iio.srv.AttrDisableTopic_Response(success=True, message='Success')


AttrReadString
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`AttrReadString` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/AttrReadString adi_iio/srv/AttrReadString "{
        attr_path:  xadc/input_temp0/raw
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.AttrReadString_Request(attr_path='xadc/input_temp0/raw')

    response:
    adi_iio.srv.AttrReadString_Response(success=True, message='2690')


AttrWriteString
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`AttrWriteString` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/AttrWriteString adi_iio/srv/AttrWriteString "{
        attr_path: m2k-dac-a/voltage0/raw,
        value: 123
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.AttrWriteString_Request(attr_path='m2k-dac-a/voltage0/raw', value='123')

    response:
    adi_iio.srv.AttrWriteString_Response(success=True, message='123')


BufferCreate
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferCreate` service documentation.

**Usage:**

.. code-block:: shell

    # Device has 2 inpus channels
    ros2 service call /adi_iio_node/BufferCreate adi_iio/srv/BufferCreate "{
        device_path: 'm2k-adc',
        channels: ['voltage0', 'voltage1'],
        samples_count: 8,
    }"

    # Alternatively, you can explicitly specify the channel direction
    ros2 service call /adi_iio_node/BufferCreate adi_iio/srv/BufferCreate "{
        device_path: 'm2k-adc',
        channels: ['input_voltage0', 'input_voltage1'],
        samples_count: 8,
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferCreate_Request(device_path='m2k-adc', channels=['voltage0', 'voltage1'], samples_count=8)

    response:
    adi_iio.srv.BufferCreate_Response(success=True, message='Success', layout=std_msgs.msg.MultiArrayLayout(dim=[std_msgs.msg.MultiArrayDimension(label='samples', size=8, stride=16), std_msgs.msg.MultiArrayDimension(label='channels', size=2, stride=2)], data_offset=0))


BufferDestroy
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferDestroy` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/BufferDestroy adi_iio/srv/BufferDestroy "{
        device_path: 'm2k-adc'
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferDestroy_Request(device_path='m2k-adc')

    response:
    adi_iio.srv.BufferDestroy_Response(success=True, message='Success')


BufferDisableTopic
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferDisableTopic` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/BufferDisableTopic adi_iio/srv/BufferDisableTopic "{
        device_path: 'm2k-adc',
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferDisableTopic_Request(device_path='m2k-adc')

    response:
    adi_iio.srv.BufferDisableTopic_Response(success=True, message='Success')


BufferEnableTopic
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferEnableTopic` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/BufferEnableTopic adi_iio/srv/BufferEnableTopic "{
        device_path: 'm2k-adc',
        topic_name: 'm2k-adc'
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferEnableTopic_Request(device_path='m2k-adc', topic_name='m2k-adc')

    response:
    adi_iio.srv.BufferEnableTopic_Response(success=True, message='Success')


.. note::

    The ``BufferEnableTopic`` service is used to stream the buffer data to a topic.
    For this, you need to create a buffer using the ``BufferCreate`` service first.


BufferRead
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferRead` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/BufferRead adi_iio/srv/BufferRead "{
        device_path: 'm2k-adc',
        channels: ['voltage0', 'voltage1'],
        samples_count: 8
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferRead_Request(device_path='m2k-adc', channels=['voltage0', 'voltage1'], samples_count=8)

    response:
    adi_iio.srv.BufferRead_Response(success=True, message='Success', buffer=std_msgs.msg.Int32MultiArray(layout=std_msgs.msg.MultiArrayLayout(dim=[std_msgs.msg.MultiArrayDimension(label='samples', size=8, stride=16), std_msgs.msg.MultiArrayDimension(label='channels', size=2, stride=2)], data_offset=0), data=[61, -65, 60, -65, 61, -65, 60, -65, 61, -64, 62, -64, 61, -66, 60, -66]))


BufferRefill
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferRefill` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/BufferRefill adi_iio/srv/BufferRefill "{
        device_path: 'm2k-adc'
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferRefill_Request(device_path='m2k-adc')

    response:
    adi_iio.srv.BufferRefill_Response(success=True, message='Success', buffer=std_msgs.msg.Int32MultiArray(layout=std_msgs.msg.MultiArrayLayout(dim=[std_msgs.msg.MultiArrayDimension(label='samples', size=8, stride=16), std_msgs.msg.MultiArrayDimension(label='channels', size=2, stride=2)], data_offset=0), data=[61, -65, 61, -64, 62, -66, 62, -66, 62, -65, 60, -65, 60, -65, 61, -63]))

.. note::

    The ``BufferRefill`` service is used to refill the buffer with new data.
    For this, you need to create a buffer using the ``BufferCreate`` service first.


BufferWrite
--------------------------------------------------------------------------------

For complete details about the request and response format of this service,
please refer to the :ref:`BufferWrite` service documentation.

**Usage:**

.. code-block:: shell

    ros2 service call /adi_iio_node/BufferWrite adi_iio/srv/BufferWrite "{
        device_path: m2k-dac-a,
        channels: ['voltage0'],
        cyclic: 0,
        buffer: {
            layout: {
                dim: [
                    {
                    label: "samples",
                    size: 4,
                    stride: 4
                    },
                    {
                        label: "channels",
                        size: 1,
                        stride: 1
                    }
                ],
                data_offset: 0
            },
            data: [ 12345, 12345, 12345, 12345 ]
        }
    }"

The output should look like this:

.. code-block:: shell

    requester: making request: adi_iio.srv.BufferWrite_Request(device_path='m2k-dac-a', channels=['voltage0'], buffer=std_msgs.msg.Int32MultiArray(layout=std_msgs.msg.MultiArrayLayout(dim=[std_msgs.msg.MultiArrayDimension(label='samples', size=4, stride=4), std_msgs.msg.MultiArrayDimension(label='channels', size=1, stride=1)], data_offset=0), data=[12345, 12345, 12345, 12345]), cyclic=False)

    response:
    adi_iio.srv.BufferWrite_Response(success=True, message='Success')
