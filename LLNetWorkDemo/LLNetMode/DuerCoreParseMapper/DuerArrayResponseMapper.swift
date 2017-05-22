//
//  DuerArrayResponseMapper.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class DuerArrayResponseMapper<A: DuerParsedItem> {
    static func process(_ obj: AnyObject?, mapper: ((Any?) throws -> A)) throws -> [A] {
        guard let json = obj as? [[String: AnyObject]] else { throw DuerResponseMapperError.invalid }
        
        var items = [A]()
        for jsonNode in json {
            let item = try mapper(jsonNode)
            items.append(item)
        }
        return items
    }
}
