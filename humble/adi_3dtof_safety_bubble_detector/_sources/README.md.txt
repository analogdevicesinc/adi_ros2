# Analog Devices 3DToF Safety Bubble Detector

## Overview
The **ADI 3DToF Safety Bubble Detector** is a ROS(Robot Operating System) package for the Safety Bubble Detection application. The Safety Bubble Detectors are the basic building block of any AGV/AMR.
The safety zone is a virtual area around an AGV/AMR. The Safety Bubble Detectors are used to detect the
presence of any object inside this zone and prevent the AGV/AMR from colliding with the object.

The **ADI 3DToF Safety Bubble Detector** is developed as a ROS application running on the ADI’s *EVAL-ADTF3175D-NXZ* Time-of-Flight platform. The Safety Bubble Detection algorithm is highly optimized to run at 30FPS on the *EVAL-ADTF3175D-NXZ* platform.
The node uses [*ADI ToF SDK*](https://github.com/analogdevicesinc/ToF/) APIs to capture the frames from the sensor. The algorithm is run on the captured images and the output is published as ROS topics.
The Node publishes the detection flag and the output visualization image as the topics. The Depth and IR images are also published as ROS topics. The topics are published at 30FPS.

![Connection Diagram](./doc/images/adi_3dtof_safety_bubble_detector.png)

[![Humble](https://img.shields.io/badge/-Humble-green?style=plastic&logo=ros)](https://docs.ros.org/en/humble/index.html) [![Ubuntu 20.04](https://img.shields.io/badge/-UBUNTU%2020.04-orange?style=plastic&logo=ubuntu&logoColor=white)](https://releases.ubuntu.com/focal/) [![Ubuntu 22.04](https://img.shields.io/badge/-UBUNTU%2022.04-orange?style=plastic&logo=ubuntu&logoColor=white)](https://releases.ubuntu.com/jammy/) [![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](LICENSE) ![ARM64](https://img.shields.io/badge/arm64-blue?style=plastic&logo=arm&logoColor=white) ![x86_64](https://img.shields.io/badge/x86__64-blue?style=plastic&logo=intel&logoColor=white)

## Hardware

- [EVAL-ADTF3175D-NXZ Module](https://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/EVAL-ADTF3175.html#eb-overview)
- USB Type-C to Type-A cable - with 5gbps data speed support
- Host laptop with intel i5 or higher CPU running Ubuntu-20.04LTS or Ubuntu-22.04LTS

 > [!note]
 > Refer the [EVAL-ADTF3175D-NXZ User Guide](https://wiki.analog.com/resources/eval/user-guides/eval-adtf3175d-nxz) to ensure the Eval module has adequate power supply during operation.

 > [!important]
 > The EVAL-ADTF3175D-NXZ Sensor module must have a firmware version of at least **5.2.5.0**. Refer to [user guide](https://wiki.analog.com/resources/eval/user-guides/eval-adtf3175d-nxz-upgrade-firmware) on firmware upgrade, or see [upgrading the firmware](#upgrading-the-firmware).

![Connection Diagram](./doc/images/connection_diagram.png)


# adi_3dtof_safety_bubble_detector_node

## Operation Modes
This package has three different operation modes. Refer to the following intra-links to setup the package accordingly.
1. [Camera Sensor Mode](#camera-sensor-mode)
2. [File-IO Mode](#file-io-mode)
3. [Network Mode](#network-mode)

## Camera Sensor Mode
The package is built on the sensor module and directly interfaces with the image sensor. The adi_3dtof_nxp_ubuntu_20_04_relx.x.x.img provided for the EVAL-ADTF3175D-NXZ sensor already contains this ROS package and is pre-built. In order to use this package, first we need to connect the sensor to the PC, and then SSH into it:

1. SSH into the Sensor
```bash
ssh analog@10.43.0.1
Password: analog
```

2. Source ROS Humble
```bash
source /opt/ros/humble/install/setup.bash
```
3. Source the workspace
```bash
source ~/ros2_ws/install/setup.bash
```
4. Launch the `adi_3dtof_safety_bubble_detector` package.
```bash
ros2 launch adi_3dtof_safety_bubble_detector adi_3dtof_safety_bubble_detector_single_camera_launch.py arg_input_sensor_mode:=0
```

> [!note]
> The operation mode is determined by the launch parameter `arg_input_sensor_mode:=0`. This can be modified in the launch file. Refer to the [parameter](#parameters) table to see what other parameters can be passed.

### Updating the package

> [!warning]
> The time and date may be incorrect on the sensor and this can cause issues when updating the package. To update the time and date, refer to [updating date and time](#updating-date-and-time).

In order to update and rebuild package to the latest version, run the following commands:
```bash
cd ~/ros2_ws/src/adi_3dtof_safety_bubble_detector
git pull
cd ~/ros2_ws
export MAKEFLAGS="-j1"
colcon build --symlink-install --executor sequential --cmake-args -DCMAKE_BUILD_TYPE=Release -DNXP=1 --packages-up-to adi_3dtof_safety_bubble_detector
```

## File-IO Mode
In this camera mode, the package is built on the Host PC in order to evaluate the properties of the package by running a pre-recorded bin file which contains the outputs from the sensor module.

### Building the package for file-io
1. On your PC, create a workspace
```bash
mkdir -p ~/ros2_ws/src
```
2. Clone the repository
```bash
cd ~/ros2_ws/src
git clone https://github.com/analogdevicesinc/adi_3dtof_safety_bubble_detector.git -b v2.1.0
cd ..
```
3. Build the workspace
```bash
rosdep install --from-paths src --ignore-src -r -y
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release -DSENSOR_CONNECTED=False
```
### Running the node in file-io
In order to run the package in file-io, it needs input files provided in the release image. Follow the steps below to use existing bin files, or follow the **Creating Bin files for File-IO** section in [adi_3dtof_adtf31xx](https://github.com/analogdevicesinc/adi_3dtof_adtf31xx) readme to create your own bin files.
1. Go to the installation directory of the ADI 3DToF ADTF31xx application `~/Analog Devices/ADI3DToFSafetyBubbleDetector-Rel2.1.0`
2. Run the `get_videos.sh` script which will download the `adi_3dtof_input_video_files.zip` file in the current directory.
3. Unzip it and copy the directory to `~/ros2_ws/src/adi_3dtof_input_video_files`.
4. Update the input file argument `arg_in_file_name` in the launch file `adi_3dtof_safety_bubble_detector_single_camera_launch.py` as per the above file path.
5. Run the following commands:
```bash
# Source the workspace
source ~/ros2_ws/install/setup.bash

# Launch the package
ros2 launch adi_3dtof_safety_bubble_detector adi_3dtof_safety_bubble_detector_single_camera_launch.py arg_input_sensor_mode:=2
```

> [!note]
> The `arg_input_sensor_mode:=2` sets the node to operate in file-io mode. This can be set in the launch file. Refer to the [parameter](#parameters) table to see what other parameters can be passed.
> Enabling file input may slow down the speed of publishing.

## Network Mode
The sensor can be operated in network mode where depth and AB (Active Brightness) images are fetched over the local area network. And safety bubble alogirthm is run on the host. The simplest way to use this is to connect the sensor directly to the PC so that a network interface via USB is created with a default IP address of `10.43.0.1`. In order to use the Network mode, follow the following steps:

### Building the package
The `adi_3dtof_safety_bubble_detector` depends on [libaditof](https://github.com/analogdevicesinc/libaditof) in order to communicate with the sensor. So we will need to build this in the same workspace as `adi_3dtof_safety_bubble_detector`.

1. On your PC, create the workspace and clone the required repositories.
```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/analogdevicesinc/adi_3dtof_safety_bubble_detector.git -b v2.1.0
git clone https://github.com/analogdevicesinc/libaditof.git -v v6.0.1

# Initialize the submodules for libaditof
cd libaditof
git submodule update --init --recursive

# Return to root of workspace folder
cd ../..
```
2. Install dependencies
```bash
rosdep install --from-paths src --ignore-src -r -y
```
3. Build the packages
```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-up-to adi_3dtof_safety_bubble_detector
source install/setup.bash
```

### Running the node in network mode
To run the node in network mode, run
```bash
ros2 launch adi_3dtof_safety_bubble_detector adi_3dtof_safety_bubble_detector_single_camera_launch.py arg_input_sensor_mode:=3 arg_input_sensor_ip:=10.43.0.1
```
> [!note]
> The `arg_input_sensor_mode:=3` sets the node to operate in network mode. This value can be adjusted in the launch file. `arg_input_sensor_ip` must be set to the IP of the sensor. Refer to the [parameter](#parameters) table to see what other parameters can be passed.


## Parameters

| Parameter                                       | Type       | Default                               | Description                                                                                     |
|-------------------------------------------------|------------|---------------------------------------|-----------------------------------------------------------------------------------------------------|
| **var_cam1_base_frame**                           | String     | "adi_camera_link"                    | Name of camera Link                                                                                 |
| **var_cam1_base_frame_optical**                   | String     | "optical_camera_link"                | Name of optical camera Link                                                                         |
| **var_virtual_camera_base_frame**                   | String     | "virtual_camera_link"                | Name of virtual camera Link                                                                         |
| **arg_safety_bubble_radius_in_mtr**             | float      | 1.0f                                 | Safety zone radius                                                                                  |
| **arg_safety_bubble_shape**                   | int        | 0                                    | Safety bubble shape, _0: circular, 1: Square_                                                       |
| **arg_virtual_camera_height_z_in_mtr**                 | float      | 5.0f                                 | Virtual camera height, default value is 5 meters.                                                   |
| **arg_input_sensor_mode**                     | int        | 0                                    | Input mode, _0: Real Time Sensor, 2: Rosbag bin, 3: Network Mode_                                   |
| **arg_output_mode**                    | int        | 0                                    | Output mode, _0: No output files written, 1: avi and csv output files are written_                  |
| **arg_input_file_name_or_ros_topic_prefix_name** | String     | "no name"                            | Input filename: Applicable only if the input mode is 2. Represents input file name or topic prefix. |
| **arg_enable_ransac_floor_detection**         | int        | true                                 | Enable option for RANSAC floor detection, _0: disable, 1: enable_                                   |
| **arg_enable_depth_ab_compression**           | int        | false                                | Enable option to publish depth and IR compressed images, _0: disable, 1: enable_                   |
| **arg_enable_output_image_compression**       | int        | false                                | Enable option to publish compressed output image, _0: disable, 1: enable_                          |
| **arg_safety_bubble_detection_sensitivity**             | int        | 10                                   | Number of connected pixels to trigger object detection                                              |
| **arg_enable_floor_paint**                    | int        | false                                | Enable option to visualize floor paint, _0: disable, 1: enable_                                     |
| **arg_enable_safety_bubble_zone_visualization** | int        | false                                | Enable option to visualize safety bubble zone, _0: disable, 1: enable_                              |                                                |
| **arg_ransac_distance_threshold_mtr**         | float      | 0.025f                               | The height of the floor RANSAC can find, default value is 2.5 cm                                    |
| **arg_ransac_max_iterations**                 | int        | 10                                   | Maximum iterations RANSAC is allowed                                                               |
| **arg_ab_threshold**                          | int        | 10                                   | abThreshold for the sensor                                                                          |
| **arg_confidence_threshold**                  | int        | 10                                   | Confidence threshold for the sensor. Default value varies based on sensor serial number.            |                                                     |
| **arg_config_file_name_of_tof_sdk**           | String     | "config/config_adsd3500_adsd3100.json" | Configuration file name of ToF SDK. Varies based on Eval Board series.                             |
| **arg_camera_mode**                            | int     | 3                                | Frame Type. Varies based on Eval Board series.                                                      |

## Camera Modes

| Imager Type       | Mode Name     | Mode Value |
|-------------------|---------------|------------|
| [ADSD3100](https://www.analog.com/en/products/adsd3100.html)          | sr-native     | 0          |
|                   | lr-native     | 1          |
|                   | sr-qnative    | 2          |
|                   | lr-qnative    | 3          |
|                   | sr-mixed      | 5          |
|                   | lr-mixed      | 6          |
| [ADSD3030](https://www.analog.com/en/products/adsd3030.html)          | sr-native     | 0          |
|                   | lr-native     | 1          |
|                   | lr-qnative    | 3          |
|                   | sr-mixed      | 5          |
|                   | lr-mixed      | 6          |
| Other modes       | -             | -          |

## Topics
| Topic                              | Description                                                                                         |
|------------------------------------|-----------------------------------------------------------------------------------------------------|
| **/depth_image**                   | 16-bit Depth image                                                                                  |
| **/ab_image**                      | 16-bit IR image                                                                                     |
| **/out_image**                     | 8-bit output image                                                                                  |
| **/object_detected**               | Boolean to indicate the object detection                                                            |
| **/camera_info**                   | Camera info                                                                                         |
| **/depth_image/compressedDepth**   | 16-bit Depth image from `adi_3dtof_safety_bubble_detector` node compressed with RVL compression (if enabled)  |
| **/ab_image/compressedDepth**      | 16-bit IR image from `adi_3dtof_safety_bubble_detector` node compressed with RVL compression (if enabled)     |
| **/out_image/compressed**          | 8-bit output image from `adi_3dtof_safety_bubble_detector` node compressed with JPEG compression (if enabled) |

## Output Images

Sample output images are shown below:

```/cam1/depth_image```
![depth_image](doc/images/depth_image.png)

```/cam1/ab_image```
![ab_image](doc/images/ab_image.png)

```/cam1/out_image```
![output_image](doc/images/out_image.png)

> [!note]
> To setup Safety Bubble Detector with 4 devices refer [Setting up 4 device for Safety Bubble Detector](doc/4DevicesSetup.md)


## Parameter Tuning
Some parameters of *adi_3dtof_safety_bubble_detector* ROS node can be modifed during runtime. The Perspective file is present in ```rqt_config/``` folder.

![Dynamic Reconfigure](./doc/images/adi_3dtof_safety_bubble_detector_rqt.png)
The GUI can be started by running the following command.

```bash
ros2 launch adi_3dtof_safety_bubble_detector adi_3dtof_safety_bubble_detector_rqt_launch.py
```

Make sure the *adi_3dtof_safety_bubble_detector node* is already running before executing this command.

# Appendix:
## Updating Date and Time
The customized ubuntu image loaded into the sensor will automatically connect to any WiFi hotspot with the SSID as `ADI` and password set as `analog123`. This network connection will automatically sync the system time using the available internet connection.

## Build Flags
| Flag Name                      | Type     | Default Value     |  Description                                                                       |
|--------------------------------|----------|-------------------|------------------------------------------------------------------------------------|
| **SENSOR_CONNECTED**           | Boolean  | TRUE              | Set to `TRUE` if a sensor is connected, otherwise set to `FALSE` for File-IO mode. |
| **BUILD_SBD_STITCH_HOST_NODE** | Boolean  | FALSE             | Set to `TRUE` to build the `adi_3dtof_safety_bubble_detector_stitch_host_node`.    |

## Upgrading the firmware
To check the existing firmware version, log into the sensor device via SSH.
```bash
$ ssh analog@10.43.0.1
   Username: analog
   Password: analog
```
Run command:
```bash
cd ~/Workspace/Tool/ctrl_app
./ctrl_app
```
Your output would look like this:
```
V4L2 custom control interface app version: 1.0.1
59 31
05 02 05 00 61 35 39 61 66 61 64 36 64 36 63 38 65 37 66 62 31 35 33 61 32 64 62 38 63 64 38 38 34 30 33 35 39 66 31 37 31 39 35 61
59 31
```
The first four values in the third line represents the version number, in this case, 5.2.5.0. If it is lower than this value, follow these steps below to update.
1. On your PC, install ADI ToF SDK release [v6.0.1](https://github.com/analogdevicesinc/ToF/releases/tag/v6.0.1)
2. After installing goto the installation folder and run the following commands to download the image
   ```bash
   cd ~/Analog\ Devices/ToF_Evaluation_Ubuntu_ADTF3175D-Relx.x.x/image.
   chmod +x get_image.sh
   ./get_image.sh.
   ```
   - Latest image will be downloaded at ./image path as NXP-Img-Relx.x.x-ADTF3175D-.zip. Extract this folder using unzip NXP-Img-Relx.x.x-ADTF3175D-.zip command.
   - This folder contains the NXP image and ADSD3500 firmware(Fw_Update_x.x.x.bin).
3. Run the following command to copy the Fimware to the NXP device
   ```bash
   $ scp Fw_Update_5.2.5.bin analog@10.43.0.1:/home/analog/Workspace
      Username: analog
      Password: analog
   ```
4. Now login to the device and run the Firmware upgrade command.
> [!warning]
> Do NOT reboot the board or interrupt the process as this may corrupt the module
   ```bash
   $ ssh analog@10.43.0.1
      Username: analog
      Password: analog
   $ cd Workspace/ToF/build/examples/data_collect/
   $ ./data_collect --fw ~/Workspace/Fw_Update_x.x.x.bin config/config_default.json
   ```
-  Reboot the board after the successful operation.

<br>
<br>

