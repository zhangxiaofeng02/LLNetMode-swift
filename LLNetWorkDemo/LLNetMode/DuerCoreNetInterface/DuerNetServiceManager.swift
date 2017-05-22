//
//  DuerNetServiceManager.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class DuerNetServiceManager {
    private let conf: DuerNetServiceConfiguration
    private let service = DuerNetWorkService()
    
    init(_ conf: DuerNetServiceConfiguration) {
        self.conf = conf
    }
    
    func request(_ request: DuerNetServiceRequestAPI, success:((AnyObject) -> ())? = nil, failure: ((NSError) ->())? = nil) {
        let url = conf.baseURL.appendingPathComponent(request.endpoint)
        service.makeRequest(for: url, method: request.method, paramerType: request.paramType, params: request.params, headers: request.headers, success: { (data) in
            var json: AnyObject? = nil
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
            }
            success?(json!)
            
        }) { (data, error, statusCode) in
            if statusCode == 401 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:""), object:nil)
                return
            }
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
                let info = [
                    NSLocalizedDescriptionKey: json?["error"] as? String ?? "",
                    NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                ]
                let error = NSError(domain: "DuerService", code: 0, userInfo: info)
                failure?(error)
            } else {
                failure?(error ?? NSError(domain: "DuerService", code: 0, userInfo: nil))
            }
        }
    }
    
    func upload(_ request: DuerNetServiceRequestAPI, success: ((AnyObject) -> ())? = nil, failure: ((NSError) -> ())? = nil) {
        let url = conf.baseURL.appendingPathComponent(request.endpoint)
        service.uploadRequest(for: url, bodyData: request.paramsData, headers: request.headers, success: { (data) in
            var json: AnyObject? = nil
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
            }
            success?(json!)
            
        }) { (data, error, statusCode) in
            if statusCode == 401 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:""), object:nil)
                return
            }
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
                let info = [
                    NSLocalizedDescriptionKey: json?["error"] as? String ?? "",
                    NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                ]
                let error = NSError(domain: "DuerService", code: 0, userInfo: info)
                failure?(error)
            } else {
                failure?(error ?? NSError(domain: "DuerService", code: 0, userInfo: nil))
            }
        }
    }
    
    func cancle() {
        service.cancel()
    }

}
