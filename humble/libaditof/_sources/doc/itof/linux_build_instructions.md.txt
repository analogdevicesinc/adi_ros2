# Linux Build Instructions

**Please note, use the applicable tag, when cloning, and release version when getting the latest depth compute library files for the embedded system. As of writing, version 5.0.0 of the release is available as well as tag v5.0.0.**

Note, all actities below are assuming to be done in a base folder.

## Building libaditof

### Dependencies

* CMake
* Glog v0.6.0
* Libwebsockets v3.1
* Protocol Buffers v3.9.0


Dependencies are included as submodules and are built, installed and linked during cmake-time of the project.

* To install and link Glog library use cmake flag:
  - ```-DWITH_GLOG_DEPEDENCY=ON```
* To install and link Websockets library use cmake flag:
  - ```-DWITH_NETWORK=ON```
* To install and link Protobuf library use cmake flag:
  - ```-DWITH_PROTOBUF_DEPENDENCY=ON```

<details>
  <summary>Build and Install Dependencies manually (OPTIONAL) [Click]</summary>

  * Glog:
  ```console
  pushd .
  git clone --branch v0.6.0 --depth 1 https://github.com/google/glog
  cd glog
  mkdir build_0_6_0 && cd build_0_6_0
  cmake -DWITH_GFLAGS=off -DCMAKE_INSTALL_PREFIX=/opt/glog ..
  sudo cmake --build . --target install
  popd
  ```

  * Libwebsockets (OPTIONAL, only if not using submodules):
  ```console
  pushd .
  git clone --branch v3.1-stable --depth 1 https://github.com/warmcat/libwebsockets
  cd libwebsockets
  mkdir build_3_1 && cd build_3_1
  cmake -DLWS_WITH_SSL=OFF -DLWS_STATIC_PIC=ON -DCMAKE_INSTALL_PREFIX=/opt/websockets ..
  sudo cmake --build . --target install
  popd
  ```

  * Protobuf (OPTIONAL, only if not using submodules):
  ```console
  pushd .
  git clone --branch v3.9.0 --depth 1 https://github.com/protocolbuffers/protobuf
  cd protobuf
  mkdir build_3_9_0 && cd build_3_9_0
  cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/opt/protobuf ../cmake
  sudo cmake --build . --target install
  cd ../..
  popd
  ```

  If you do not use the submodules and have installed the dependencied (Protobuf, Libwebsockets) manually, run the following export command:
```console
export CMAKE_PREFIX_PATH="/opt/glog;/opt/protobuf;/opt/websockets"
```

</details>


### Download and build libaditof

Please note, ensure you are using the intended branch.

```console
git clone --branch v5.0.0 --depth 1 https://github.com/analogdevicesinc/libaditof
cd libaditof
git submodule update --init
mkdir build && cd build
cmake ..
make -j4
```

See [here](../../cmake/readme.md) for details on the cmake options.

## Generate doxygen documentation

Requirements:
* Doxygen
* Graphviz

```console
sudo apt-get install doxygen graphviz
```

In order to generate the doxygen documentation you must compile the sdk in the following way:
```console
cmake -DWITH_DOC=on ..
make -j4 doc
```
After compilation, the documentation can be found at this path:
```console
build/doc/doxygen_doc/html/index.html
```
