# NXP Build Instructions

## Dependencies

Please note, the libs folder below must contain libtofi_compute.so and libtofi_config.so. This folder and these two files are on the SD card image that is a part of the eval kit.

These are the ARM64 depth compute libraries. 

```
base folder
├── libs
│   ├── libtofi_compute.so
│   └── libtofi_config.so
└── libaditof
```

Other dependencies are already installed on the NXP.

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

### Depth Compute:

The Depth Compute library is required to build the SDK and run any application based on the SDK.
Based on the following scenarios you will be able to do the following:

1. You have the **arm development package for nxp** (libtofi_compute.so, libtofi_config.so) for the Depth Compute library. With it you will be able to build the SDK. The files should be included in the SD card image (~\Workspace\libs). You just need to put the files mentioned above in a directory called 'libs' which should be placed at the same level as the repository directory.

    If you prefer to keep the files somewhere else, you can tell cmake where to find them using the cmake variable: LIBTOFI_LIBDIR_PATH

2. You have no Depth Compute packages. In this case you can still build the SDK by enabling the USE_DEPTH_COMPUTE_OPENSOURCE option but you won't have access to the functionality that Depth Compute provides.

### Download and build libaditof

Please note, ensure you are using the intended branch.

```console
git clone --branch v5.0.0  https://github.com/analogdevicesinc/libaditof
cd libaditof
git submodule update --init
mkdir build && cd build
cmake -DNXP=1 ..
make -j4
```
