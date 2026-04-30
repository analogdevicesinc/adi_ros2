# syntax=docker/dockerfile:1

ARG ROS_DISTRO=humble
ARG OVERLAY=/opt/ros/adi_ros2

FROM adi_ros2:${ROS_DISTRO}-core AS sdk

FROM ros:${ROS_DISTRO}-ros-core

ARG OVERLAY

# Copy the adi_iio package (includes exec_debs.txt)
COPY --from=sdk ${OVERLAY}/adi_iio ${OVERLAY}/adi_iio

# Install only this package's runtime dependencies
RUN apt-get update \
  && xargs -r apt-get install -y < ${OVERLAY}/adi_iio/share/adi_iio/exec_debs.txt \
  && rm -rf /var/lib/apt/lists/*

# Source package environment
RUN sed -i \
    's|exec "$@"|source "'"${OVERLAY}"'/adi_iio/share/adi_iio/local_setup.bash" --\nexec "$@"|' \
    /ros_entrypoint.sh

ENV OVERLAY=${OVERLAY}
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
