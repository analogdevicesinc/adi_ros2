# `adi_iio` – ROS2 Package for IIO Integration


## Overview

The `adi_iio` package bridges the gap between Analog Devices’ IIO hardware and
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


## Getting Started

To help you quickly get started with the adi_iio package, we have organized
detailed documentation into several [guides](./doc/):

> **Note:** *Some links in this README work only in the CI-built documentation.*

- For information on **prerequisites, repository setup, and building the package**,
  please refer to the [Installation Guide](#installation).

- For instructions on **how to build the project documentation locally,** please
  refer to the [Building the Documentation Guide](#building_the_documentation).

- To learn **how to launch the package** and begin processing sensor data, see the
  [Quick Start Guide](#quick_start).

- For information regarding **node parameters, service interfaces, and topic
  communications,** please refer to the [Node Description Guide](#node_description).

- For more in-depth **information for developers on how to contribute to this project,**
  please refer to the [Contributing Section](#contributing) of this document.


## Getting Help

- **Issue Tracker:** Report bugs, request features, or submit technical queries
  via our Issue Tracker.

- **FAQ:** Consult our [FAQ Document](./doc/FAQ.rst) for answers to common questions.

- **Further Guidance:** For additional communication guidelines, refer to [COMMUNICATION](COMMUNICATION.md).


## Contributing

Contributions are key to our project’s success. Before submitting changes:

- Familiarize yourself with our code and testing conventions.

- Consult the [CONTRIBUTING.md](CONTRIBUTING.md) for detailed instructions.

- Ensure your code adheres to our design values and guidelines.

## License

This project is licensed under the  [**Apache License, Version 2.0 LICENSE**](LICENSE).

## Changelog
Refer to our [CHANGELOG](CHANGELOG.md) file for version history and release notes.
