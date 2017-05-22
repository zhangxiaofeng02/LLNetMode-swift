//
//  GetUserInfoOperation.swift
//  LLNetWorkDemo
//
//  Created by 啸峰 on 17/5/22.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

// MARK: 构造请求API
class GetUserInfoOperationAPI: DuerNetServiceRequestAPI {
    
    var userID: String
    
    public init(userID: String) {
        self.userID = userID
    }
    
    var endpoint: String {
        return "/user/info"
    }
    
    var method: DuerNetWorkService.HTTPMethod {
        return .post
    }
    
    var paramType: DuerNetWorkService.ParamerType {
        return .json
    }
    
    var headers: [String : String]? {
        return defaultJSONHeaders()
    }
    
    var params: [String : Any]? {
        return ["userID": self.userID];
    }
    
    var paramsData: Data? {
        return nil;
    }
}

// MARK: 构造请求操作

class GetUserInfoOperation: DuerNetServiceOperation {
    
    private var request: GetUserInfoOperationAPI
    
    public var success: ((UserInfoItem) -> ())?
    public var failed: ((Error) -> ())?
    
    public init(userID: String) {
        request = GetUserInfoOperationAPI(userID: userID)
        super.init()
    }
    
    public override func start() {
        super.start()
        service.request(request, success: { (response) in
            do {
                let item = try GetUserInfoOperationMapper.process(response)
                self.success?(item)
                self.finish()
            } catch {
                self.failed?(NSError.cannotParseResponse())
                self.finish()
            }

        }) { (error) in
            print(error)
            self.failed?(error)
            self.finish()
        }
    }
    
    public override func cancel() {
        super.cancel()
    }
}

// MARK: 构造解析mapper

class GetUserInfoOperationMapper: DuerResopnseMapper<UserInfoItem>, DuerResponseMapperProtocol {
    static func process(_ obj: AnyObject?) throws -> UserInfoItem {
        return try process(obj, parse: { (json) -> UserInfoItem? in
            let userName = json["userName"] as! String
            let userAge = json["userAge"] as! Int
            return UserInfoItem(userName: userName, userAge: userAge)
        })
    }
}

// MARK: 构造实体类

struct UserInfoItem: DuerParsedItem {
    public var userName: String
    public var userAge: Int
    
}
