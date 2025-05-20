<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="class">
    <name>AttrPubSub</name>
    <filename>classAttrPubSub.html</filename>
  </compound>
  <compound kind="class">
    <name>BoolPubSub</name>
    <filename>classBoolPubSub.html</filename>
    <base>AttrPubSub</base>
  </compound>
  <compound kind="class">
    <name>Float32PubSub</name>
    <filename>classFloat32PubSub.html</filename>
    <base>AttrPubSub</base>
  </compound>
  <compound kind="class">
    <name>IIOAttrTopic</name>
    <filename>classIIOAttrTopic.html</filename>
    <base>UpdateCallback</base>
  </compound>
  <compound kind="class">
    <name>IIOBuffer</name>
    <filename>classIIOBuffer.html</filename>
  </compound>
  <compound kind="class">
    <name>IIONode</name>
    <filename>classIIONode.html</filename>
  </compound>
  <compound kind="class">
    <name>IIOPath</name>
    <filename>classIIOPath.html</filename>
    <member kind="function">
      <type></type>
      <name>IIOPath</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>ad83ab64c410b2df2fee394ea78f28cb3</anchor>
      <arglist>(std::string path, char delimiter=&apos;/&apos;)</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>basePath</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>aa089783a455bca56348d522880cb3484</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>getContextAttrSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a135e59c460f8b33cc03f4e75b7dfe1d9</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>getDeviceSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a628013ed289d637eb19ec39718e1fb02</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>getDeviceAttrSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a5c6da9bcf16b0a46c5b2bb8123185098</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>getChannelSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a68ca6f2b86b988adee46b4a519c1d38d</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::pair&lt; bool, std::string &gt;</type>
      <name>getExtendedChannelSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a09da667d213f45666b9274e59d2cb223</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>hasExtendedChannelFormat</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>adaaa6afd58114d2a2fdfc588c271ec9d</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>getChannelAttrSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a0930e5c4ec67786816e86d20cf5630ae</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>append</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a5267692c774185c148b6047d32b64879</anchor>
      <arglist>(const std::string &amp;suffix)</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>isValid</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a83cbc5d8608ef1a58e117fad3bb29670</anchor>
      <arglist>(const IIOPathType type)</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; std::string &gt;</type>
      <name>split</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a13168489d39273e5aeac4c2071b44c34</anchor>
      <arglist>(const std::string &amp;str)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static std::string</type>
      <name>toExtendedChannelSegment</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a995b880525f2c98fef7048f04f054d3f</anchor>
      <arglist>(bool output, std::string chn_name)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static std::string</type>
      <name>toTopicName</name>
      <anchorfile>classIIOPath.html</anchorfile>
      <anchor>a0f86b783a1d79228e0601499db6d1577</anchor>
      <arglist>(std::string path)</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>Int32PubSub</name>
    <filename>classInt32PubSub.html</filename>
    <base>AttrPubSub</base>
  </compound>
  <compound kind="class">
    <name>StringPubSub</name>
    <filename>classStringPubSub.html</filename>
    <base>AttrPubSub</base>
  </compound>
  <compound kind="class">
    <name>UpdateCallback</name>
    <filename>classUpdateCallback.html</filename>
  </compound>
</tagfile>
