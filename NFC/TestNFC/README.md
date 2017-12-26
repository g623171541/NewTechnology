# nfc
test NFC function

1   登录Apple Developer账户，注册一个新的 APP ID，并勾选 NFC Tag Reading

2   创建 provisioning profile，下载并双击导入项目

3   打开项目中 Capabilities 的 Near Field Communication Tag Reading

4   在Info.plist 配置 Privacy：

        <key>NFCReaderUsageDescription</key>
        <string>insert your usage description</string>
	
5   编写程序，步骤

        @import CoreNFC 导入框架，这点没啥可说的
        遵循 NFCNDEFReaderSessionDelegate 协议
        创建 NFCNDEFReaderSession 实例
        开启 NFCNDEFReaderSession 以及处理协议回调方法
