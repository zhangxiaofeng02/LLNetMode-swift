//
//  ViewController.swift
//  LLNetWorkDemo
//
//  Created by 啸峰 on 17/5/22.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化网络配置
        DemoNetWorkConfig.setup()
        
        //初始化单次网络请求
        let operation = GetUserInfoOperation(userID:"123")
        //成功的回调
        operation.success = { item in
            let item: UserInfoItem = item
                print(item.userName)
        }
        //失败的回调
        operation.failed = { error in
            print(error)
        }
        //添加到队列中
        DuerNetWorkQueue.shared.addOpetaion(operation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class DemoNetWorkConfig {
    class func setup() {
        let url = URL(string:"http://www.baidu.com")!
        let conf = DuerNetServiceConfiguration(baseURL: url)
        DuerNetServiceConfiguration.shared = conf
        DuerNetWorkQueue.shared = DuerNetWorkQueue()
    }
}
