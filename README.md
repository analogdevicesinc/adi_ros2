# Mission

`adi_ros2` aims to streamline the use of [Analog Devices Inc.](http://www.analog.com/en/index.html)
(ADI) packages within ROS2 by providing a single meta-repo for quick access to
all ADI-supported packages for each ROS 2 release. The project includes CI
scripts that provide methods to build system dependencies from source, which
cannot be resolved otherwise. These scripts are centralized within a Docker
wrapper, allowing you to build a local Docker image that can compile the ROS2
packages provided in the repository. In addition, it generates and
consolidates documentation, making it easier for developers to reference and
contribute. We welcome contributions that refine these packages, improve CI
coverage, or expand documentation to further support robotics projects built
on ADI solutions.


## Getting Started

- The Docker image with Analog Devices packages for ROS2 is available in
  [this repository](https://hub.docker.com/repository/docker/astanea/adi_ros2/general).

- For detailed instructions, please refer to our
  [Official Documentation](src/adi_ros2/doc/index.rst).

## Getting help

- **Issue Tracker:** Report bugs, request features, or submit technical queries

- **Further Guidance:** For additional communication guidelines, refer to [COMMUNICATION](COMMUNICATION.md).


## Who We Are

- **Project Maintainers:** This project is maintained by the **adi-ros2-iio-maintainers** team.

- **Repository Administrators:** Administration of this repository is managed
  by the **adi-ros2-team-admins** group.

- **Committers and Contributors:** Trusted committers and contributors adhere
  to our organizational guidelines. For comprehensive information on
  our team structure and practices, please visit our
  [central information page](https://hub.analog.com/home).


## Contributing

Contributions are key to our project’s success. Before submitting changes:

- Familiarize yourself with our code and testing conventions.

- Consult the [CONTRIBUTING.md](CONTRIBUTING.md) for detailed instructions.

- Ensure your code adheres to our design values and guidelines.


## License

Please [check each project](./src/) to see its specific license terms.
