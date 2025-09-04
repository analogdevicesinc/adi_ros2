#!/usr/bin/env bash

set -eou pipefail

BASE_PATH=$(git rev-parse --show-toplevel)

echo "Installing dependencies"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y graphviz doxygen

echo "Generating the build directory"
mkdir -p "$BASE_PATH"/_build

echo "Building the docs using rosdoc2"
pushd "$BASE_PATH"/_build >/dev/null || exit

# Generate docs for each submodule
for submodule in $(git submodule | awk '{ print $2 }' | xargs); do
    if [[ "$submodule" == *dependencies* ]]; then
        echo "Skipping dependency submodule: $submodule"
        continue
    fi
    echo "Submodule: $submodule"
    rosdoc2 build --package-path "$submodule" --debug
done

# Generate docs fo the meta package which links to the submodules
rosdoc2 build --package-path "$BASE_PATH/src/adi_ros2" --debug

popd >/dev/null
