^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package adi_iio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.0.1 (2025-07-17)
------------------
* Enhanced hardware testing workflow with environment variable controls.

* Contributors: Adrian-Stanea

1.0.0 (2025-06-27)
------------------
* Automated Hardware Testing Infrastructure:

  * Setup of test workflows on self-hosted runners, with access to Pluto SDR device.

* Added system test validation and documentation.

* Examples and Documentation Enhancements:

  * Added examples for HWMON, AD5592R and AD7124_8 devices, showcasing service usage and buffer operations.
  * Documented service usage and examples for specific devices.

* Code Quality and CI/CD updates:

  * Improved CI/CD workflows for building, testing, and linting.
  * Added pre-commit hooks for code style checks.
  * Enhanced documentation generation using adidoctools guidelines.

* Service Interfaces:

  * Discovery Services:

    * ``ScanContext`` - Comprehensive IIO context scanning service that returns lists of devices, channels, and attributes formatted as IIO paths.
    * ``ListDevices`` - Lists all IIO device paths found in the current context.
    * ``ListChannels`` - Lists all channel paths for a specified device.
    * ``ListAttributes`` - Lists attribute paths for context, device, or channel targets.

  * Attribute Management Services:

    * ``AttrReadString`` - Reads string values from IIO attributes specified by path.
    * ``AttrWriteString`` - Writes string values to IIO attributes specified by path.
    * ``AttrEnableTopic`` - Enables real-time topic publishing for attributes with configurable data types (String, Int, Double, Bool) and update rates.
    * ``AttrDisableTopic`` - Disables topic publishing for specified attributes.

  * Buffer Operation Services:

    * ``BufferCreate`` - Initializes buffers for continuous data capture from specified device channels.
    * ``BufferDestroy`` - Stops buffer operations and releases associated resources.
    * ``BufferRead`` - Convenience service combining buffer destruction, creation, and data acquisition in one call.
    * ``BufferWrite`` - Pushes sample data to hardware devices with optional cyclic mode for repeated transmission.
    * ``BufferRefill`` - Transfers data from hardware device to client via Int32MultiArray response.
    * ``BufferEnableTopic`` - Initiates continuous data capture and publishes to associated topics.
    * ``BufferDisableTopic`` - Stops continuous buffer data transfer to topics.

* Added launch file support for the Node.
* Initial revision of the adi_iio package.

* Contributors: Adrian Suciu, Adrian-Stanea
