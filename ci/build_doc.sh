#!/usr/bin/env bash

set -eou pipefail

BASE_PATH=$(git rev-parse --show-toplevel)
CROSS_REF_DIR="$BASE_PATH/_build/cross_refs"

echo "Installing system dependencies"

declare -A REQUIRED_PACKAGES=(
    [doxygen]="doxygen"
    [graphviz]="dot"
)

# Check if any required command is missing
MISSING_PACKAGES=false
for package in "${!REQUIRED_PACKAGES[@]}"; do
    if ! command -v "${REQUIRED_PACKAGES[$package]}" &> /dev/null; then
        MISSING_PACKAGES=true
        break
    fi
done

if [ "$MISSING_PACKAGES" = true ]; then
    sudo apt-get update
    for package in "${!REQUIRED_PACKAGES[@]}"; do
        if ! command -v "${REQUIRED_PACKAGES[$package]}" &> /dev/null; then
            echo "Installing $package"
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$package"
        fi
    done
else
    echo "All required system dependencies already installed"
fi

echo "Setting up Python virtual environment"
python3 -m venv "$BASE_PATH/.venv-doc"
# shellcheck source=/dev/null
source "$BASE_PATH/.venv-doc/bin/activate"
pip install --upgrade pip
pip install -r "$BASE_PATH/src/adi_ros2/doc/requirements.txt"

echo "Generating the build directory"
mkdir -p "$BASE_PATH/_build"
mkdir -p "$CROSS_REF_DIR"

echo "Building the docs using rosdoc2"
pushd "$BASE_PATH/_build" >/dev/null || exit

# Explicit build order: base drivers first, algorithms after, meta last.
# Order matters: each package's objects.inv is written to CROSS_REF_DIR
# and read by subsequent builds for cross-package symbol resolution.
BUILD_ORDER=(
    "src/iio_ros2"
    "src/imu_ros2"
    "src/adrd2121_imu_ros2"
    "src/tmcl_ros2"
    "src/adi_3dtof_adtf31xx"
    "src/algorithms/adi_3dtof_safety_bubble_detector"
    "src/algorithms/adi_3dtof_floor_detector"
)

for submodule in "${BUILD_ORDER[@]}"; do
    if [ -d "$BASE_PATH/$submodule" ]; then
        echo "Submodule: $submodule"
        rosdoc2 build \
            --package-path "$BASE_PATH/$submodule" \
            --cross-reference-directory "$CROSS_REF_DIR"
    else
        echo "Skipping missing submodule: $submodule"
    fi
done

# adi_tmc_coe_ros2 contains multiple packages; build each sub-directory.
for package_dir in "$BASE_PATH/src/adi_tmc_coe_ros2"/*/; do
    if [ -d "$package_dir" ] && [ -f "${package_dir}package.xml" ]; then
        echo "Generating docs for package: $package_dir"
        rosdoc2 build \
            --package-path "$package_dir" \
            --cross-reference-directory "$CROSS_REF_DIR"
    fi
done

# Meta package built last so it can resolve all sibling package symbols
rosdoc2 build \
    --package-path "$BASE_PATH/src/adi_ros2" \
    --cross-reference-directory "$CROSS_REF_DIR" \
    --debug

popd >/dev/null
