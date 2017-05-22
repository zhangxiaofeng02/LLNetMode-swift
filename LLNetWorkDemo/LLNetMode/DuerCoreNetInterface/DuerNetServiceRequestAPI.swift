//
//  DuerNetServiceRequestAPI.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

protocol DuerNetServiceRequestAPI {
    var endpoint: String { get }
    var method: DuerNetWorkService.HTTPMethod { get }
    var paramType: DuerNetWorkService.ParamerType { get }
    var params: [String:Any]? { get }
    var headers: [String:String]? { get }
    var paramsData: Data? {get}
}

extension DuerNetServiceRequestAPI {
    func defaultJSONHeaders() -> [String:String] {
        return ["Content-Type": "application/json"]
    }
}
