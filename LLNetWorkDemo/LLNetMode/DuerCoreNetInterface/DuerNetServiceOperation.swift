//
//  DuerNetServiceOperation.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class DuerNetServiceOperation: DuerNetWorkOperation {
    let service: DuerNetServiceManager
    
    public override init() {
        self.service = DuerNetServiceManager(DuerNetServiceConfiguration.shared)
        super.init()
    }
    
    public override func cancel() {
        service.cancle()
        super.cancel()
    }
}
