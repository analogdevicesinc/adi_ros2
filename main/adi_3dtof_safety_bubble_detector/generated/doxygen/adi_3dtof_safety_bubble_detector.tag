<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="struct">
    <name>__tADI2DPoint</name>
    <filename>struct____tADI2DPoint.html</filename>
  </compound>
  <compound kind="struct">
    <name>__tADIImage</name>
    <filename>struct____tADIImage.html</filename>
  </compound>
  <compound kind="struct">
    <name>__tADIImageROI</name>
    <filename>struct____tADIImageROI.html</filename>
  </compound>
  <compound kind="class">
    <name>ADI3DToFSafetyBubbleDetector</name>
    <filename>classADI3DToFSafetyBubbleDetector.html</filename>
    <member kind="function">
      <type></type>
      <name>ADI3DToFSafetyBubbleDetector</name>
      <anchorfile>classADI3DToFSafetyBubbleDetector.html</anchorfile>
      <anchor>a378e9019829cd482a06a467fd8e5d688</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADI3DToFSafetyBubbleDetector</name>
      <anchorfile>classADI3DToFSafetyBubbleDetector.html</anchorfile>
      <anchor>aa85a520605bd4fd056e908d5808d950c</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ADI3DToFSafetyBubbleDetectorOutputInfo</name>
    <filename>classADI3DToFSafetyBubbleDetectorOutputInfo.html</filename>
    <member kind="function">
      <type></type>
      <name>ADI3DToFSafetyBubbleDetectorOutputInfo</name>
      <anchorfile>classADI3DToFSafetyBubbleDetectorOutputInfo.html</anchorfile>
      <anchor>a2fa627733791e2949c10177ee9e51802</anchor>
      <arglist>(int image_width, int image_height)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADI3DToFSafetyBubbleDetectorOutputInfo</name>
      <anchorfile>classADI3DToFSafetyBubbleDetectorOutputInfo.html</anchorfile>
      <anchor>a66f7077a54f539a6b94b2a4b33f05e35</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ADISensorFrameInfo</name>
    <filename>classADISensorFrameInfo.html</filename>
    <member kind="function">
      <type></type>
      <name>ADISensorFrameInfo</name>
      <anchorfile>classADISensorFrameInfo.html</anchorfile>
      <anchor>a8a6e20c04d8f7ef289727a7183db8dc3</anchor>
      <arglist>(int image_width, int image_height)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADISensorFrameInfo</name>
      <anchorfile>classADISensorFrameInfo.html</anchorfile>
      <anchor>ad93b88f3ecfce25856baf6dcea1df841</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ADTF31xxSensorFrameInfo</name>
    <filename>classADTF31xxSensorFrameInfo.html</filename>
    <member kind="function">
      <type></type>
      <name>ADTF31xxSensorFrameInfo</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>afae0c0b2743410daedecf223f741521d</anchor>
      <arglist>(int image_width, int image_height)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADTF31xxSensorFrameInfo</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a6817e4132bb8e263d1a49ad2d340adb3</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>unsigned short *</type>
      <name>getDepthFrame</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a4ae5e3b48239e5c43b31ddb3360f4072</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned short *</type>
      <name>getIRFrame</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>ae5f51fb4e46cd93c0d45f01bc4bb5130</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>short *</type>
      <name>getXYZFrame</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a9271647c3cdf54d936edeea1a2568ffe</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>short *</type>
      <name>getRotatedXYZFrame</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a8bf71fc15c7e42110c43cb1e9ddfeb8c</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned char *</type>
      <name>getCompressedDepthFrame</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a16f4dfbad9c5df744f25cac9aba26b72</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned char *</type>
      <name>getCompressedIRFrame</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a8c5c09a7a0130774b3a7dba5087776f3</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>rclcpp::Time *</type>
      <name>getFrameTimestampPtr</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a0580cccfca341b7990367d73838c50b6</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>rclcpp::Time</type>
      <name>getFrameTimestamp</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a5f479d2ad8b5981831d7a454dc972c0d</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getCompressedDepthFrameSize</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a31b6ab731eeb78542e9ab601ffe74c4a</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getCompressedIRFrameSize</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>ae041c0229e40289c436a4b7a5dc2c17e</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setCompressedDepthFrameSize</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>aa2b371705acdaa9fdffc18164fcf8542</anchor>
      <arglist>(int compressed_depth_frame_size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setCompressedIRFrameSize</name>
      <anchorfile>classADTF31xxSensorFrameInfo.html</anchorfile>
      <anchor>a01524c94db9ae0ebe87000352fed0fa5</anchor>
      <arglist>(int compressed_ab_frame_size)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>InputSensorRosTopic</name>
    <filename>classInputSensorRosTopic.html</filename>
    <base>IInputSensor</base>
    <member kind="function">
      <type>void</type>
      <name>setABinvalidationThreshold</name>
      <anchorfile>classInputSensorRosTopic.html</anchorfile>
      <anchor>a223b0cf1d23c55f91aae0850df15fcb5</anchor>
      <arglist>(int)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setConfidenceThreshold</name>
      <anchorfile>classInputSensorRosTopic.html</anchorfile>
      <anchor>ae9657ce49afe88d78307de3c5424e933</anchor>
      <arglist>(int)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>OOutputSensor</name>
    <filename>classOOutputSensor.html</filename>
  </compound>
  <compound kind="class">
    <name>OutputSensorFactory</name>
    <filename>classOutputSensorFactory.html</filename>
    <member kind="function" static="yes">
      <type>static OOutputSensor *</type>
      <name>getOutputSensor</name>
      <anchorfile>classOutputSensorFactory.html</anchorfile>
      <anchor>a545d16636c78d75cb9b049079c85b4b1</anchor>
      <arglist>(int output_sensor_type)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>OutputSensorFile</name>
    <filename>classOutputSensorFile.html</filename>
    <base>OOutputSensor</base>
  </compound>
</tagfile>
