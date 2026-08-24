<h1 style="text-align: center;" > Analog Devices 3DToF Floor Detector</h1>

## Overview
The **ADI 3DToF Floor Detector** is a ROS (Robot Operating System) package for the Floor Detection application. The term "Floor Detection" refers to determining where the floor is in the given image. It is an image segmentation problem in which a given image is divided into floor and non-floor pixels. Floor Detection is an essential component of real-world applications such as Robot Navigation, Autonomous Driving, Augmented reality (AR) applications, and 'Obstacles Detection and Avoidance' for robots and people with inadequate vision.
Here is the sample output of **ADI 3DToF Floor Detector**. From the left, AB image & Depth image and Floor marked depth image can be seen below.


![Floor Detection Diagram](./doc/images/floor_detection.png)


The **ADI 3DToF Floor Detector** is developed as a ROS application running on the ADI’s *EVAL-ADTF3175D-NXZ* Time-of-Flight platform. The node uses [*ADI ToF SDK*](https://github.com/analogdevicesinc/ToF/) APIs to capture the frames from the sensor. The algorithm runs on the captured depth image and the outputs are published as ROS topics. The node publishes the Camera Info, Floor Mask Image along with Depth & AB Images.


[![Humble](https://img.shields.io/badge/-humble-green?style=plastic&logo=ros)](https://docs.ros.org/en/humble/index.html) [![Ubuntu 22.04](https://img.shields.io/badge/-UBUNTU%2022.04-orange?style=plastic&logo=ubuntu&logoColor=white)](https://releases.ubuntu.com/jammy/) [![Ubuntu 20.04](https://img.shields.io/badge/-UBUNTU%2020.04-orange?style=plastic&logo=ubuntu&logoColor=white)](https://releases.ubuntu.com/focal/) ![ARM64](https://img.shields.io/badge/arm64-blue?style=plastic&logo=arm&logoColor=white) ![x86_64](https://img.shields.io/badge/x86__64-blue?style=plastic&logo=intel&logoColor=white) [![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](./LICENSE.txt)

## Hardware
- [EVAL-ADTF3175D-NXZ Module](https://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/EVAL-ADTF3175.html#eb-overview)
- USB type-C to type-A cable - with 5gbps data speed support
- Host laptop with intel i5 or higher cpu running Ubuntu-20.04LTS or with Ubuntu-22.04

 > [!note]
 > Refer the [EVAL-ADTF3175D-NXZ User Guide](https://wiki.analog.com/resources/eval/user-guides/eval-adtf3175d-nxz) to ensure the Eval module has the adequate power supply during the operation.

 > [!important]
 > The EVAL-ADTF3175D-NXZ Sensor module must have a firmware version of at least **5.2.5.0**. Refer to [user guide](https://wiki.analog.com/resources/eval/user-guides/eval-adtf3175d-nxz-upgrade-firmware) on firmware upgrade, or see [upgrading the firmware](#upgrading-the-firmware).

![Connection Diagram](./doc/images/connection_diagram.png)

# adi_3dtof_floor_detector_node

## Operation Modes
This package has three different operation modes. Refer to the following intra-links to setup the package accordingly.
1. [Camera Sensor Mode](#camera-sensor-mode)
2. [File-IO Mode](#file-io-mode)
3. [Network Mode](#network-mode)

## Camera Sensor Mode

The package is built on the sensor module and directly interfaces with the image sensor. The adi_3dtof_nxp_ubuntu_20_04_relx.x.x.img provided for the EVAL-ADTF5175D-NXZ sensor already contains this ROS package and is pre-built. In order to use this package, first we need to connect the sensor to the PC, and then SSH into it:

1. SSH into the Sensor
```bash
$ ssh analog@10.43.0.1
$ Password: analog
```

2. Source ROS Humble
```bash
$ source /opt/ros/humble/install/setup.bash
```
3. Source the workspace
```bash
$ source ~/ros2_ws/devel/setup.bash
$ export LD_LIBRARY_PATH=~/ros2_ws/install/lib:$LD_LIBRARY_PATH
```
4. Launch the `adi_3dtof_floor_detector` package.
```bash
$ ros2 launch adi_3dtof_floor_detector adi_3dtof_floor_detector_launch.py arg_input_mode:=0
```

> [!note]
> The operation mode is determined by the launch parameter `arg_input_mode:=0`. This can be modified in the launch file. Refer to the [parameter](#parameters) table to see what other parameters can be passed.

### Updating the package

> [!warning]
> The time and date may be incorrect on the sensor and this can cause issues in updating the package. To update the time and date, refer to [updating date and time](#updating-date-and-time).

In order to update and rebuild package to the latest version, run the following commands:
```bash
cd ~/ros2_ws/src/adi_3dtof_floor_detector
git pull
cd ~/ros2_ws
export MAKEFLAGS="-j1"
colcon build --symlink-install --executor sequential --cmake-args -DCMAKE_BUILD_TYPE=Release -DNXP=1 --packages-up-to adi_3dtof_floor_detector
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
git clone https://github.com/analogdevicesinc/adi_3dtof_floor_detector.git -b v2.1.0
cd ..
```
3. Build the workspace
```bash
$ rosdep install --from-paths src --ignore-src -r -y
$ colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release -DSENSOR_CONNECTED=False
```

### Running the node in file-io
In order to run the package in file-io, it needs input files provided in the release image. Follow the steps below to use existing bin files, or follow **Creating Bin files for File-IO** section in [adi_3dtof_adtf31xx](https://github.com/analogdevicesinc/adi_3dtof_adtf31xx) readme to create your own bin files.
1. Go to the installation directory of the ADI 3DToF ADTF31xx application `~/Analog Devices/ADI3DToFFloorDetector-Rel2.1.0`
2. Run the `get_videos.sh` script which will download the `adi_3dtof_input_video_files.zip` file in the current directory.
3. Unzip it and copy the directory to `~/ros2_ws/src/adi_3dtof_input_video_files`.
4. Update the input file argument `arg_input_file_name` in the launch file `adi_3dtof_floor_detector.launch` as per the above file path.
5. Run the following commands:
```bash
# Source the workspace
$ source ~/ros2_ws/install/setup.bash

# Launch the package
$ ros2 launch adi_3dtof_floor_detector adi_3dtof_floor_detector_launch.py arg_input_mode:=2
```

> [!note]
> The `arg_input_mode:=2` sets the node to operate in file-io mode. This can be set in the launch file. Refer to the [parameter](#parameters) table to see what other parameters can be passed.

## Network Mode

The sensor can be operated in network mode where depth and AB (Active Brightness) images are fetched over the local area network. The simplest way to use this is to connect the sensor directly to the PC so that a network interface via USB is created with a default IP address of `10.43.0.1`. In order to use the network mode, follow the following steps:

### Building the package
The `adi_3dtof_floor_detector` depends on [libaditof](https://github.com/analogdevicesinc/libaditof) in order to communicate with the sensor. So we will need to build this in the same workspace as `adi_3dtof_floor_detector`.

1. On your PC, create the workspace and clone the required repositories.
```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/analogdevicesinc/adi_3dtof_floor_detector.git -b v2.1.0
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
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-up-to adi_3dtof_floor_detector
source install/setup.bash
```

### Running the node in network mode
To run the node in network mode, run
```bash
ros2 launch adi_3dtof_floor_detector adi_3dtof_floor_detector_launch.py arg_input_mode:=3 arg_input_sensor_ip:=10.43.0.1
```
> [!note]
> The `arg_input_mode:=3` sets the node to operate in network mode. This value can be adjusted in the launch file. `arg_input_sensor_ip` must be set to the IP of the sensor. Refer to the [parameter](#parameters) table to see what other parameters can be passed.


## Parameters

| Parameter                                     | Type          | Default                         | Description                                                                |
|-----------------------------------------------|---------------|---------------------------------|----------------------------------------------------------------------------|
| **arg_input_mode**                            | int           | 0                               | Input mode, _0: Real Time Sensor, 2: Rosbag bin, 3: Network Mode_          |
| **arg_output_mode**                           | int           | 0                               | Output mode, _0: No output files written, 1: avi and csv output files are written_    |
| **arg_input_file_name**                       | String        | "no name"                       | Input filename: Applicable only if the input mode is 2 or 3. If input mode is 2, this parameter represents input file name. If input mode is 3, this parameter represents the prefix of ROS topics.   |
| **arg_camera_mode**                           | int           | 3                               | Frame Type: _1 - For LR-Native Mode, 3 - For LR-QNative Mode_              |
| **arg_ab_threshold**                          | int      | 10                                   | The abThreshold-based filter for the sensor                                |
| **arg_confidence_threshold**                  | int      | 10                                   | The confidenceThreshold-based filter for the sensor                        |
| **arg_config_file_name_of_tof_sdk**           | String   | "config/config_crosby_old_modes.json" | Configuration file name of ToF SDK: _"config_adsd3500_adsd3100.json" - For ADSD3100 Devices, "config_adsd3500_adsd3030.json" - For ADSD3030 Devices_    |
| **arg_enable_ransac_floor_detection**         | int      | 1                                    | Enable option for RANSAC floor detection, _0: disable, 1: enable_          |
| **arg_enable_fallback_floor_detection**       | int      | 1                                    | Enable option for fallback floor detection when RANSAC fails, _0: disable, 1: enable_ |
| **arg_ransac_distance_threshold_mtr**         | float    | 0.025f                               | The allowed distance offset from the RANSAC floor plane, default value is 2.5 cm      |
| **arg_ransac_max_iterations**                 | int      | 10                                   | The maximum iterations that RANSAC is allowed to run                       |
| **arg_discard_distance_threshold_mtr**        | float    | 1.5f                                 | The points with depth value lesser than the given threshold are considered, default value is 1.5 m      |
| **arg_fallback_floor_height_offset_mtr**      | float    | 0.1f                                 | The floor height offset for the fallback (3D Yw-based) floor detection, default value is 10 cm          |
| **arg_enable_compression_op_image_topics**    | int      | 0                                    | The enable option to publish compressed output images (Depth, AB, Floor Mask), _0: disable, 1: enable_  |

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

## Published topics

| Topic                              | Description                                                                     |
|------------------------------------|---------------------------------------------------------------------------------|
| **/cam1/depth_image**               | 16-bit Depth image                                                              |
| **/cam1/ab_image**                  | 16-bit AB image                                                                 |
| **/cam1/camera_info**               | Camera info                                                                     |
| **/cam1/floor_mask**                | 8-bit Floor Mask image                                                          |
| **/cam1/depth_image/compressedDepth** | 16-bit Depth image compressed with RVL compression technique (if enabled)     |
| **/cam1/ab_image/compressedDepth**    | 16-bit AB image compressed with RVL compression technique (if enabled)        |
| **/cam1/compressed_floor_mask**       |  8-bit Floor Mask image compressed with custom compression technique (if enabled) |

## Outputs

The below image shows subscribed AB, Depth and Floor mask output images in RVIZ.

![RVIZ Output Diagram 1](./doc/images/rviz_output_1.png)





# adi_3dtof_floor_detector_example_node

The package also provides a ROS2 node *adi_3dtof_floor_detector_example_node* which can be used to understand how to use the output from the ADI Floor Detector algorithm. The *adi_3dtof_floor_detector_example_node* subscribes to the output topics of *adi_3dtof_floor_detector_node* from the device and generates the output images. The output image topics of *adi_3dtof_floor_detector_node* can be either compressed or uncompressed.

1. Clone the repo and checkout the correct release branch/tag into catkin workspace/src directory
```bash
$ cd ~/ros2_ws/src
$ git clone https://github.com/analogdevicesinc/adi_3dtof_floor_detector.git -b v2.1.0
```
2. Install dependencies:
```bash
$ cd ~/ros2_ws/
$ rosdep install --from-paths src -y --ignore-src
```
3. Build the package
```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-up-to adi_3dtof_floor_detector
source install/setup.bash
```
4. This node can be run in 2 ways using the following command in a new terminal.

 >[!note]
Make sure that the ADI 3DToF Floor Detector node is already running on a device before running this node.

Using RVIZ,

In adi_3dtof_floor_detector_example_rviz_launch.py file change the parameter
param name=```image_transport``` to ```raw```  for raw image.
param name=```image_transport``` to ```compressedDepth```  for compressed images.
then run the below command.
```bash
$ ros2 launch adi_3dtof_floor_detector adi_3dtof_floor_detector_example_rviz_launch.py
```

At this stage, the *adi_3dtof_floor_detector_example_node* will be launched and start publishing the output topics ```floor_marked_depth_image, floor_removed_depth_image```. The RVIZ will also be launched and outputs are shown as below.

![RVIZ Output Diagram 2](./doc/images/rviz_output_2.png)

Using RQT,

In adi_3dtof_floor_detector_example_rqt_launch.py file change the parameter
param name=```image_transport``` to ```raw```  for raw image.
param name=```image_transport``` to ```compressedDepth```  for compressed images.
then run the below command.
```bash
$ ros2 launch adi_3dtof_floor_detector adi_3dtof_floor_detector_example_rqt_launch.py
```
At this stage, the *adi_3dtof_floor_detector_example_node* will be launched and start publishing the output topics ```floor_marked_depth_image, floor_removed_depth_image```. The RQT will also be launched and outputs are shown as below.


![RQT Output Diagram](./doc/images/rqt_output.png)


Here, the displayed parameters can be changed in run-time. This will help in fine-tuning and evaluating the algorithm.

7. Optionally, you can enable floor removed point cloud output by changing the parameter in the adi_3dtof_floor_detector_example_rviz_launch.py file as shown below.
```bash
<arg name="arg_enable_pointcloud_output" default="1" />
```
To visualize the point cloud output, add the ```floor_removed_point cloud``` in the RVIZ. If the point cloud output is enabled when the outputs of the *adi_3dtof_floor_detector_node* are not compressed then the process might slow down. For the best usage, recommended option is to enable compression on outputs of *adi_3dtof_floor_detector_node* when the point cloud output is required.


## Parameters

| Parameter                         | Type     | Default     | Description                                                                                         |
|-----------------------------------|----------|-------------|-----------------------------------------------------------------------------------------------------|
| **arg_rostopic_cam_prefix**       | String   | cam1        | ROS Topic prefix name to subscribe                                                                  |
| **arg_enable_pointcloud_output**  | int      | 0           | The enable option for the floor removed point cloud output                                          |
| **compression_parameter**         | String   | raw         | In this node, image transport subscribers are utilized. The `image_transport` parameter indicates the type of publisher topic to subscribe to. Options: "raw" - raw images, "compressedDepth" - compressed 16-bit images. |

## Subscribed topics

| Topic                                | Description                                                              |
|--------------------------------------|--------------------------------------------------------------------------|
| **/cam1/depth_image**                 | 16-bit Depth image                                                       |
| **/cam1/ab_image**                    | 16-bit AB image                                                          |
| **/cam1/camera_info**                 | Camera info                                                              |
| **/cam1/floor_mask**                  | 8-bit Floor Mask image                                                   |
| **/cam1/depth_image/compressedDepth** | 16-bit Depth image compressed with RVL compression technique             |
| **/cam1/ab_image/compressedDepth**    | 16-bit AB image compressed with RVL compression technique                |
| **/cam1/compressed_floor_mask**       |  8-bit Floor Mask image compressed with custom compression technique     |


## Published topics

| Topic                         | Description                                    |
|-------------------------------|------------------------------------------------|
| **/floor_marked_depth_image** | 16-bit Depth image                             |
| **/floor_removed_depth_image**| 16-bit AB image                                |
| **/floor_removed_point_cloud**| The floor removed point cloud (if enabled)     |


# Appendix
## Updating Date and Time
The customized ubuntu image loaded into the sensor will automatically connect to any WiFi hotspot with the SSID as `ADI` and password set as `analog123`. This network connection will automatically sync the system time using the available internet connection.

## Build Flag
| Flag                           | Type     | Default Value     | Description                                                                        |
|--------------------------------|----------|-------------------|------------------------------------------------------------------------------------|
| **SENSOR_CONNECTED**           | Boolean  | TRUE              | Set to `TRUE` if a sensor is connected, otherwise set to `FALSE` for File-IO mode. |

## Upgrading the firmware
To check the existing firmware version, log into the sensore device via SSH.
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
   chmod +x get_image.sh and ./get_image.sh.
   ```
   - Latest image will be downloaded at ./image path as NXP-Img-Relx.x.x-ADTF3175D-.zip. Extract this folder using unzip NXP-Img-Relx.x.x-ADTF3175D-.zip command.
   - This folder contains the NXP image and ADSD3500 firmware(Fw_Update_x.x.x.bin).
3. Run the following command to copy the Firmware to the NXP device
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

## Limitations
1. Compression on the point cloud is not supported.
2. The *adi_3dtof_floor_detector_node* can only subscribe to uncompressed ROS image topics.

## Support
Please contact the `Maintainers` if you want to evaluate the algorithm for your own setup/configuration.

Any other inquiries are also welcome.







