.. _quick_start:

Quick Start
================================================================================

Launch Files
--------------------------------------------------------------------------------

To launch the node, you can use the provided launch file ``dev_adi_iio_launch.py``.
This launch file sets the necessary ``uri`` parameter.

.. code-block:: sh

    ros2 launch adi_iio_node dev_adi_iio_launch.py

Additionally, a small Python script is available to visualize the waveform using
matplotlib plots. The script uses the ``topic`` parameter to subscribe to the
topic where the waveform is published and plot the waveforms.

.. code-block:: sh

    python3 visualize_iio_waveform.py --topic /m2k_adc
