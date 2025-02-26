# Contributing Guidelines

Thank you for your interest in contributing to `adi_ros2`. Whether it's a bug
report, new feature, correction, or additional documentation, we greatly value
feedback and contributions from our community.

Please read through this document before submitting any issues or pull requests
to ensure we have all the necessary information to effectively respond to your
bug report or contribution.


## How to Contribute


### Adding New Repositories

- **Include as a submodule:** when adding a new repository, ensure that it is
  added as a Git submodule under the `src` folder. Also list the package name
  as a dependency for the [meta-package](./src/adi_ros2/package.xml).

- **Handle System Dependencies:** for any new repository, verify that its system
  dependencies are properly addressed. If a dependency cannot be resolved by
  `rosdep` and must be built from source, include the necessary support files
  (refer to the `ci` folder for reference). This ensures that the project builds
  correctly in various environments.

- **Dockerfile Guidance:** use the provided [Dockerfile](./ci/docker/Dockerfile)
  in this repository as a reference for where and how dependencies should be
  placed. After you define the required dependencies and add the new submodule,
  update and rebuild the Dockerfile accordingly

### Workflow and Best Practices

- **Workspace Setup:** Treat this repository as your development workspace for
  colcon builds.

- **Testing and Documentation:** along with your contributions, please add or
  update tests and documentation as needed.


## Becoming a Trusted Committers

Becoming a Trusted Committer is about consistently contributing value to the project and supporting its community. Here are some suggestions to help you grow into this role:

1. **Contribute Regularly**: Submit high-quality contributions, including code, documentation, and reviews, that align with the project's standards and best practices.

2. **Collaborate Actively**: Engage positively with maintainers and contributors by participating in discussions, offering constructive feedback, and fostering a collaborative environment.

3. **Follow Best Practices**: Adhere to the project's coding, documentation, and contribution guidelines to set a strong example for others.

4. **Be Responsive**: Actively review pull requests, respond to issues, and assist other contributors in a timely and respectful manner.

5. **Take Ownership**: Show initiative by taking responsibility for specific areas of the project, ensuring their quality, maintenance, and alignment with project goals.


## Licensing

Please [check each project](./src/) to see its specific license terms.
