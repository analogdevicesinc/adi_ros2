# imu_ros2 target device
DEVICE_ID ?= adis16505-2
export DEVICE_ID

EXECUTOR ?= sequential # sequential|parallel
export EXECUTOR

OVERLAY ?= /opt/ros/adi_ros2
export OVERLAY

CMAKE_ARGS ?= -DCMAKE_BUILD_TYPE=Release
export CMAKE_ARGS

# Packages to skip during build (space-separated list)
SKIP_PACKAGES ?=
export SKIP_PACKAGES

# Internal variable to handle skip packages argument
ifneq ($(strip $(SKIP_PACKAGES)),)
SKIP_PACKAGES_ARG = --packages-skip $(SKIP_PACKAGES)
else
SKIP_PACKAGES_ARG =
endif

all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make clone            - clone all ADI ROS2 packages sources"
	@echo "   2. make deps             - install all dependencies via rosdep"
	@echo "   3. make build-system     - build all ADI ROS2 package and install under /opt/ros/adi_ros2"
	@echo "   4. make build-local      - build all ADI ROS2 packages locally in the current workspace"
	@echo "   5. make clean            - clean all build artifacts"
	@echo ""
	@echo "   Variables:"
	@echo "   	DEVICE_ID: ID of the target device (default: adis16505-2) - deprecated, use runtime parameter instead"
	@echo "   	EXECUTOR: colcon executor to use (default: sequential)"
	@echo "   	OVERLAY: installation directory for build-system (default: /opt/ros/adi_ros2)"
	@echo "   	CMAKE_ARGS: additional cmake arguments (default: -DCMAKE_BUILD_TYPE=Release)"
	@echo "   	SKIP_PACKAGES: space-separated list of packages to skip during build (default: none)"
	@echo ""

clone:
	@echo "Cloning ADI ROS2 packages..."
	@mkdir -p src
	@vcs import --recursive src < adi_ros2-${ROS_DISTRO}.yml

deps:
	# With retry logic to handle server issues or network problems
	@echo "Installing dependencies..."
	@rosdep update --rosdistro ${ROS_DISTRO}
	@max_retries=20; count=0; \
	until rosdep install -y --from-paths src --skip-keys "libiio-dev" --ignore-src; do \
		count=$$((count+1)); \
		if [ $$count -ge $$max_retries ]; then \
			echo "rosdep install failed after $$max_retries attempts."; \
			exit 1; \
		fi; \
		echo "rosdep install failed. Retrying in 5 seconds... ($$count/$$max_retries)"; \
		sleep 5; \
	done

build-system:
	@echo "Building ADI ROS2 packages..."
	@MAKEFLAGS="-l1 -j1 " colcon build \
		--event-handlers console_cohesion+ \
	 	--executor ${EXECUTOR} \
		--install-base ${OVERLAY} \
		--merge-install \
		--cmake-args ${CMAKE_ARGS} \
		$(SKIP_PACKAGES_ARG)
	@echo "Build artifacts location: ${OVERLAY}/"

build-local:
	@echo "Building ADI ROS2 packages locally..."
	@MAKEFLAGS="-l1 -j1" colcon build \
		--event-handlers console_cohesion+ \
	 	--executor ${EXECUTOR} \
		--symlink-install \
		--cmake-args ${CMAKE_ARGS} \
		$(SKIP_PACKAGES_ARG)
	@echo "Build artifacts location: ${WORKSPACE}/"

clean-build:
	@echo "Cleaning build artifacts..."
	@rm -rf build/ install/ log/

clean:
	@echo "Cleaning all build artifacts..."
	@rm -rf build/ install/ log/ src/