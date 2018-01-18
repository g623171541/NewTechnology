//
//  ViewController.swift
//  TestNFC
//
//  Created by PaddyGu on 2017/10/18.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController ,NFCNDEFReaderSessionDelegate{
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var nfcSession: NFCNDEFReaderSession?
    
    /*      NFC Data Exchange Format : NFC数据交换格式
 
     步骤：
     @import CoreNFC 导入框架，这点没啥可说的
     遵循 NFCNDEFReaderSessionDelegate 协议
     创建 NFCNDEFReaderSession 实例
     开启 NFCNDEFReaderSession 以及处理协议回调方法
 
     */
    
    
    //Apple CoreNFC 目前支持的格式有限，NFC 数据交换格式或 NDEF（通常用于当今市场上的大多数平板电脑和手机），比如 Apple Pay 。
    
    //NFC会话失败
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    //NFC会话成功
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("The session did detect")
        //你可以通过遍历并打印 messages 中的元素来了解这些信息的内容。每个元素均是 NFCDEFPayload 对象，并且每一个对象都会包括 identifier、payload、type 和 typeNameFormat 这些属性。
        for message in messages {
            for record in message.records {
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
            }
        }
        
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        
        DispatchQueue.main.async {
            self.messageLabel.text = result
        }
        
    }
    
    
    @IBAction func scanPressed(_ sender: UIButton) {
        //在 init 方法中我创建了一个会话 ，Core NFC 需要使用 NFCNDEFReaderSession 这个 class 来监听 NFC 设备，从而完成通信。（注意 NFCReaderSession 是一个抽象类，不能直接使用）
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
        //以上代码中我们创建了一个会话，并且为 Dispatch Queue 这个参数传递了一个 nil 值。这样可以使得 NFCNDEFReaderSession 自动创建一个串行 Dispatch Queue。
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

