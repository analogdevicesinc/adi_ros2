<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="class">
    <name>AdiImuBufRos2</name>
    <filename>classAdiImuBufRos2.html</filename>
    <member kind="function">
      <type></type>
      <name>AdiImuBufRos2</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a23e3f4fa2a3064a1338170f23605e666</anchor>
      <arglist>(const rclcpp::Node::SharedPtr &amp;node)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~AdiImuBufRos2</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a1b160c6f012a93b191638880815abbf4</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>initParams</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a5947f50fa4fdd1e5f565cd3e7b6c973a</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>init</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>aea4d317b9d929c88c6e0a288721bebac</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>config</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a06010fb047f5a3cc24d129c0140d271e</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>readPubData</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a660b08e8ccfdcf51781fcae291e22074</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>dataReadAndPubCB</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a29779d91a27e07236aae6f2e4fb256d0</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>double</type>
      <name>getRosLoopRateHz</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a80fe492ba31dbca0b0ef5b9008b5be30</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>triggerImuGlobCmd</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a8193ba35cab25ab2c813431fdfe4a3cd</anchor>
      <arglist>(adrd2121_imu::srv::ImuGlobCmd::Request::SharedPtr req, adrd2121_imu::srv::ImuGlobCmd::Response::SharedPtr res)</arglist>
    </member>
    <member kind="variable">
      <type>rclcpp::Service&lt; adrd2121_imu::srv::ImuGlobCmd &gt;::SharedPtr</type>
      <name>p_imu_glob_cmd_service_</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>af214c19e23577b0b2e75976d9e66e52d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>uint8_t</type>
      <name>mode_of_operation_</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a8ee044b8d299cf893e4ec03460475583</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>bool</type>
      <name>b_getHWInitialized_</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a3e182b7d85ab2e210cffdce2fab52c1b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>bool</type>
      <name>b_readPubDataSuccess</name>
      <anchorfile>classAdiImuBufRos2.html</anchorfile>
      <anchor>a326c7c4088f5625c8ac3d07cab196e4b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>AdiImuRos2</name>
    <filename>classAdiImuRos2.html</filename>
    <member kind="function">
      <type></type>
      <name>AdiImuRos2</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>ab4202a4e35241064857ac2050d54f70c</anchor>
      <arglist>(const rclcpp::Node::SharedPtr &amp;node, adi_imu_Device_t *p_device)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~AdiImuRos2</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>aae7d0b9d01752b0dbe38e5be57d00595</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>loadParams</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>a7d0317bcd9575376025513f1b34fa5b6</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>init</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>abd5ab3b09922a194378e87a582bf45f2</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>config</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>a07d7eedace366e89ec6b5eaa4a3eb834</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>double</type>
      <name>getImuDataRateHz</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>a5dc84a24bf27f38d9f1e664c26c7118a</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>triggerBiasCorrectionUpdate</name>
      <anchorfile>classAdiImuRos2.html</anchorfile>
      <anchor>ae2194e8b107218cfc2f5ae0634609822</anchor>
      <arglist>(void)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>BiasEstimateRos2</name>
    <filename>classBiasEstimateRos2.html</filename>
    <member kind="function">
      <type></type>
      <name>BiasEstimateRos2</name>
      <anchorfile>classBiasEstimateRos2.html</anchorfile>
      <anchor>a1b9a4cc77d9f7e0286cb2ffefc3ffe3e</anchor>
      <arglist>(const rclcpp::Node::SharedPtr &amp;node)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~BiasEstimateRos2</name>
      <anchorfile>classBiasEstimateRos2.html</anchorfile>
      <anchor>a87bb0226995ab1f7b70dcad190cdbb73</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>init</name>
      <anchorfile>classBiasEstimateRos2.html</anchorfile>
      <anchor>a1cbf71cf08b76a04801be3cea4b38e1a</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>biasEstimateCB</name>
      <anchorfile>classBiasEstimateRos2.html</anchorfile>
      <anchor>a4725eb593bbe5d244c432c75ee0ab749</anchor>
      <arglist>(adrd2121_imu::srv::BiasEstimateCmd::Request::SharedPtr req, adrd2121_imu::srv::BiasEstimateCmd::Response::SharedPtr res)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>checkStandStillDuration</name>
      <anchorfile>classBiasEstimateRos2.html</anchorfile>
      <anchor>a4898f17227bce92fdb3742398fca4dd2</anchor>
      <arglist>(rclcpp::Time standstill_start, double &amp;duration_secs)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ImuBufRos2</name>
    <filename>classImuBufRos2.html</filename>
    <member kind="function">
      <type></type>
      <name>ImuBufRos2</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a73bf779d657ac4a34b57358ab5fd8ee1</anchor>
      <arglist>(const rclcpp::Node::SharedPtr &amp;node, adi_imu_Device_t *p_device)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ImuBufRos2</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a7bda7f519d3ec3b7bb4e7bde9f01434b</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>loadParams</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a159102b439b45f5742764356f3f7c987</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>init</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a54ba0fd51aacd835b38d20ce021aabc6</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>config</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ad442c78a2377295fe195b942160dd3ee</anchor>
      <arglist>(msg_type_e msg_type)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>dataReadAndPub</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a168c9a7dc441bd79094bcf2f3faf249a</anchor>
      <arglist>(std::string frame_name, msg_type_e msg_type)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>validateData</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a79eeaf4e261dbb692a17f42dc836ea51</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>startBufferRead</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a4407d3530939dd793a374bf0727b75d6</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>stopBufferRead</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ae78c3c804c440871b4031c3f4ad91df3</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getBufferStatus</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ad36d5197ddc6001e9bae8945b145a234</anchor>
      <arglist>(uint16_t *status)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>factoryReset</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a00f5b46bf67183a841b9d43a48bcebae</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>clearFault</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a7c9f04cc3bee0bc8f4c11473a8e2deff</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>flashUpdate</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a04e7bd3d61a80dc7d2d5e47c4ca5057b</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>recoverBoard</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a34e72b4bb4a344271f60b3983cdf6016</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>initServiceServers</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a20e624b5984a9ed9929f04a8dae472b3</anchor>
      <arglist>(uint8_t mode_of_operation)</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>getStatusDescription</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a8940e34ebe8683bf78db202e86cd2b51</anchor>
      <arglist>(uint16_t status)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>factoryResetCB</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ad1100bd3baab34229b177c47211a0238</anchor>
      <arglist>(std_srvs::srv::Trigger::Request::SharedPtr req, std_srvs::srv::Trigger::Response::SharedPtr res)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>clearFaultCB</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>abb5bc1d1235daeaa24a7e3e5b0b4cf58</anchor>
      <arglist>(std_srvs::srv::Trigger::Request::SharedPtr req, std_srvs::srv::Trigger::Response::SharedPtr res)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>flashUpdateCB</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ab3744776feb120b041ebf707984b39e3</anchor>
      <arglist>(std_srvs::srv::Trigger::Request::SharedPtr req, std_srvs::srv::Trigger::Response::SharedPtr res)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>getBufferStatusCB</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ac5f37979ac0eda7abe2fdf057d317fde</anchor>
      <arglist>(adrd2121_imu::srv::BufStatus::Request::SharedPtr req, adrd2121_imu::srv::BufStatus::Response::SharedPtr res)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>setModeofOperation</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>ad5154ca614a247503f7b0a595c8ce726</anchor>
      <arglist>(uint8_t mode_of_operation)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>detect</name>
      <anchorfile>classImuBufRos2.html</anchorfile>
      <anchor>a4a2fc7770b5ec8f79131a560768e0f14</anchor>
      <arglist>(void)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>ImuStateCheckerRos2</name>
    <filename>classImuStateCheckerRos2.html</filename>
    <member kind="function">
      <type></type>
      <name>ImuStateCheckerRos2</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>ae4a0f5da95b152d8169096f4b65d3b5b</anchor>
      <arglist>(const rclcpp::Node::SharedPtr &amp;node)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~ImuStateCheckerRos2</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>ab4c9c9556af171770684130791b29b7b</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>e_imu_state</type>
      <name>evaluateState</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a1cac4769f2afdad3971099d9df008e2f</anchor>
      <arglist>(const sensor_msgs::msg::Imu::SharedPtr imu_msg)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>imuCallback</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>ae8e280af8fd54a7c1927e408a7de9890</anchor>
      <arglist>(const sensor_msgs::msg::Imu::SharedPtr msg)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>imuCallback</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a0a70b2c07dd50bc6f6872df90932a531</anchor>
      <arglist>(const adrd2121_imu::msg::AdiImu::SharedPtr msg)</arglist>
    </member>
    <member kind="function">
      <type>float</type>
      <name>getStandardDev</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a5765b4d4eb0caa2472347efe8f9cff52</anchor>
      <arglist>(std::deque&lt; float &gt; data)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>evaluateStandstillBegin</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a8236f2016b202ade49e7aef2d2592800</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>rclcpp::Time</type>
      <name>getStandstillBegin</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a9c5c22e34df8d545fb30cbbb74df640c</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>e_imu_state</type>
      <name>getState</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a40d57c569e0fe1eb354051728a9504db</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>loadParams</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>aba405ca2f81127b9267d4f070517e2f2</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>init</name>
      <anchorfile>classImuStateCheckerRos2.html</anchorfile>
      <anchor>a848f8e76ac5fbaf604e2e435640e700e</anchor>
      <arglist>(void)</arglist>
    </member>
  </compound>
</tagfile>
