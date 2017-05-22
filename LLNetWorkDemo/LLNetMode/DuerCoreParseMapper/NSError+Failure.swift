//
//  NSError+Failure.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

extension NSError {
    class func cannotParseResponse() -> NSError {
        let info = [NSLocalizedDescriptionKey: "Can't parse response. Please report a bug."]
        return NSError(domain: String(describing: self), code: 0, userInfo: info)
    }
}
