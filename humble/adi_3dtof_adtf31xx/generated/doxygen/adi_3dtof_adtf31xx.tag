<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="class">
    <name>ADI3DToFADTF31xx</name>
    <filename>classADI3DToFADTF31xx.html</filename>
    <member kind="function">
      <type></type>
      <name>ADI3DToFADTF31xx</name>
      <anchorfile>classADI3DToFADTF31xx.html</anchorfile>
      <anchor>a4e06f84b67f269a266db462af1db3177</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADI3DToFADTF31xx</name>
      <anchorfile>classADI3DToFADTF31xx.html</anchorfile>
      <anchor>a572f8676a5c333a79554fa772a914723</anchor>
      <arglist>() override</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ADI3DToFADTF31xxFrameInfo</name>
    <filename>classADI3DToFADTF31xxFrameInfo.html</filename>
    <member kind="function">
      <type></type>
      <name>ADI3DToFADTF31xxFrameInfo</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>ae8279c5be82e30dc96a0ee9841dc550c</anchor>
      <arglist>(int image_width, int image_height)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADI3DToFADTF31xxFrameInfo</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a6b1988ae3f4f9d503428081d7377d06f</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>unsigned short *</type>
      <name>getDepthFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>adb147e66d9df45bf3ff9172fdee683bb</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned short *</type>
      <name>getABFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>aa9247d1538507270c84626d5c8517fcf</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>short *</type>
      <name>getXYZFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a8cd085423e0f024c760291566b10d6e7</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned short *</type>
      <name>getConfFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a66f49bdd3461bcc36893f7b20fdf0664</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned char *</type>
      <name>getCompressedDepthFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>ae0b2804ead7a30537063fd5eba77809e</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned char *</type>
      <name>getCompressedABFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a4fc4ea0e0451f456301d5ac3242c009f</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>unsigned char *</type>
      <name>getCompressedConfFrame</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>aa81b98918aff4ca2cde13ecec7dc0f2f</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>rclcpp::Time *</type>
      <name>getFrameTimestampPtr</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a7fc32e322d9c55b6a3b375c6806ff4d6</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>rclcpp::Time</type>
      <name>getFrameTimestamp</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a4415dad34be15abae881107efc6e08bd</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getCompressedDepthFrameSize</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>ad6a41f39eb4cf4d485a98c10943af81a</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getCompressedABFrameSize</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>ad8369bc1735d8a6a936b74c2981f3082</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getCompressedConfFrameSize</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>aa1e75ec47b9bf54883eeb4c2af3f4b96</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setCompressedDepthFrameSize</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>ab46a8e5b4a9deaa8ac5f14514b591134</anchor>
      <arglist>(int compressed_depth_frame_size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setCompressedABFrameSize</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a391a3d70f1773f8ba77da00d6a56c9e1</anchor>
      <arglist>(int compressed_ab_frame_size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setCompressedConfFrameSize</name>
      <anchorfile>classADI3DToFADTF31xxFrameInfo.html</anchorfile>
      <anchor>a9bf79d0b36e38298b92d01f5953fff84</anchor>
      <arglist>(int compressed_conf_frame_size)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ADI3DToFADTF31xxOutputInfo</name>
    <filename>classADI3DToFADTF31xxOutputInfo.html</filename>
    <member kind="function">
      <type></type>
      <name>ADI3DToFADTF31xxOutputInfo</name>
      <anchorfile>classADI3DToFADTF31xxOutputInfo.html</anchorfile>
      <anchor>aaabda70eb7f0be5ad731fb615b964ba9</anchor>
      <arglist>(int image_width, int image_height)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ADI3DToFADTF31xxOutputInfo</name>
      <anchorfile>classADI3DToFADTF31xxOutputInfo.html</anchorfile>
      <anchor>ac4dd3bfb084e7c61820808b9ce164274</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>CameraExtrinsics</name>
    <filename>structCameraExtrinsics.html</filename>
    <member kind="variable">
      <type>float</type>
      <name>rotation_matrix</name>
      <anchorfile>structCameraExtrinsics.html</anchorfile>
      <anchor>ad42d7e4e4b95e76c65142e6994a0c3aa</anchor>
      <arglist>[9]</arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>translation_matrix</name>
      <anchorfile>structCameraExtrinsics.html</anchorfile>
      <anchor>ad3517a1a3ba8ed9ceeca1d63d54d9900</anchor>
      <arglist>[3]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>CameraIntrinsics</name>
    <filename>structCameraIntrinsics.html</filename>
    <member kind="variable">
      <type>float</type>
      <name>camera_matrix</name>
      <anchorfile>structCameraIntrinsics.html</anchorfile>
      <anchor>acda10bc01bc21640010acf097e0f44be</anchor>
      <arglist>[9]</arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>distortion_coeffs</name>
      <anchorfile>structCameraIntrinsics.html</anchorfile>
      <anchor>addb98003691f1c0d46fac95fbe2fba31</anchor>
      <arglist>[8]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>compressed_depth_image_transport::ConfigHeader</name>
    <filename>structcompressed__depth__image__transport_1_1ConfigHeader.html</filename>
  </compound>
  <compound kind="class">
    <name>IInputSensor</name>
    <filename>classIInputSensor.html</filename>
    <member kind="function">
      <type>bool</type>
      <name>isOpened</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>a0811292ecb18e8928d06993a7dbd2507</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getFrameWidth</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>a04f5e300c94ace6c0a6ce9711b8e2262</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getFrameHeight</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>a6f1d9344d355b2aaddb3444386969850</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setFrameWidth</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>a88051e6af2423784cb24f91005f9553c</anchor>
      <arglist>(int frm_width)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setFrameHeight</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>ad0076918a62979bda492139c82f7af87</anchor>
      <arglist>(int frm_height)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setProcessingScale</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>a9a264c690e89b0a639a70bdf836a6fb3</anchor>
      <arglist>(int scale_factor)</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getFrameCounter</name>
      <anchorfile>classIInputSensor.html</anchorfile>
      <anchor>a7be10a860b0f5b3bd967b63cc191ff34</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ImageProcUtils</name>
    <filename>classImageProcUtils.html</filename>
    <member kind="function">
      <type>void</type>
      <name>generateRangeTo3DLUT</name>
      <anchorfile>classImageProcUtils.html</anchorfile>
      <anchor>a04320da773cd37ef3369381e61a54c1f</anchor>
      <arglist>(CameraIntrinsics *camera_intrinsics)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>computePointCloud</name>
      <anchorfile>classImageProcUtils.html</anchorfile>
      <anchor>a8871d35fb9555129c55c762e560e5346</anchor>
      <arglist>(unsigned short *range_image, short *xyz_frame)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>InputSensorADTF31XX</name>
    <filename>classInputSensorADTF31XX.html</filename>
    <base>IInputSensor</base>
  </compound>
  <compound kind="class">
    <name>InputSensorFactory</name>
    <filename>classInputSensorFactory.html</filename>
    <member kind="function" static="yes">
      <type>static IInputSensor *</type>
      <name>getInputSensor</name>
      <anchorfile>classInputSensorFactory.html</anchorfile>
      <anchor>a8c27b0e5e5d46855ab37420486c1c092</anchor>
      <arglist>(int input_sensor_type)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>InputSensorFileRosbagBin</name>
    <filename>classInputSensorFileRosbagBin.html</filename>
    <base>IInputSensor</base>
    <member kind="function">
      <type>void</type>
      <name>setABinvalidationThreshold</name>
      <anchorfile>classInputSensorFileRosbagBin.html</anchorfile>
      <anchor>a3b98086fd748487132565447f9826474</anchor>
      <arglist>(int) override</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setConfidenceThreshold</name>
      <anchorfile>classInputSensorFileRosbagBin.html</anchorfile>
      <anchor>adc4c22e149141406e68254dee0dc53e6</anchor>
      <arglist>(int) override</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setJBLFFilterState</name>
      <anchorfile>classInputSensorFileRosbagBin.html</anchorfile>
      <anchor>ad3d2b2abb4213fdc53fa6e5e63b251e8</anchor>
      <arglist>(bool) override</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setJBLFFilterSize</name>
      <anchorfile>classInputSensorFileRosbagBin.html</anchorfile>
      <anchor>a8c44b4e1ff0798bb4c5c1340f3f4257c</anchor>
      <arglist>(int) override</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setRadialFilterMinThreshold</name>
      <anchorfile>classInputSensorFileRosbagBin.html</anchorfile>
      <anchor>a7c3e96c58f89e74def295d2d07b27734</anchor>
      <arglist>(int) override</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setRadialFilterMaxThreshold</name>
      <anchorfile>classInputSensorFileRosbagBin.html</anchorfile>
      <anchor>a7f30da1dc7928b6800149338ce1a4f5e</anchor>
      <arglist>(int) override</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>compressed_depth_image_transport::RvlCodec</name>
    <filename>classcompressed__depth__image__transport_1_1RvlCodec.html</filename>
  </compound>
</tagfile>
