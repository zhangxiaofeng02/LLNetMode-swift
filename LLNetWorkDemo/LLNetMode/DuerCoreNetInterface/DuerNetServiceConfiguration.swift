//
//  DuerNetServiceConfiguration.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

final class DuerNetServiceConfiguration {
    
    let baseURL: URL
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public static var shared: DuerNetServiceConfiguration!
    
}
