//
//  DuerNetWorkQueue.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class DuerNetWorkQueue {
    
    public static var shared: DuerNetWorkQueue!
    
    let queue = OperationQueue()
    
    public init() {}
    
    public func addOpetaion(_ op: Operation) {
        queue.addOperation(op)
    }
}
