//
//  DuerResopnseMapper.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

protocol DuerResponseMapperProtocol {
    associatedtype Item
    static func process(_ obj: AnyObject?) throws -> Item
}

internal enum DuerResponseMapperError: Error {
    case invalid, missingAttribute
}

class DuerResopnseMapper<A: DuerParsedItem> {
    static func process(_ obj:AnyObject?, parse:(_ json: [String: AnyObject]) -> A?) throws -> A {
        guard let json = obj as? [String:AnyObject] else {
            throw DuerResponseMapperError.invalid
        }
        if let item = parse(json) {
            return item
        } else {
            throw DuerResponseMapperError.missingAttribute
        }
    }
}
