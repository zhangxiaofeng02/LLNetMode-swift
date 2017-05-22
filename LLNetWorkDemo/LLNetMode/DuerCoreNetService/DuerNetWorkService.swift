//
//  DuerNetWorkService.swift
//  DuerSDK
//
//  Created by 啸峰 on 17/5/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class DuerNetWorkService: NSObject {
    
    // MARK: - pro
    
    private var task: URLSessionTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failedCodes: CountableRange<Int> = 400..<499
    
    enum HTTPMethod: String {
        case get, post, delete, upload, put
    }
    
    enum ParamerType {
        case json, path
    }
    
    func uploadRequest(for url:URL,
                       bodyData: Data? = nil,
                       headers: [String:String]? = nil,
                       success: ((Data?) -> Void)? = nil,
                       failure: ((_ data: Data?, _ error: NSError?, _ responseCode: Int) -> Void)? = nil) {
        var mutableRequest = makeQuery(for: url, params: nil, type: .path)
        mutableRequest.httpMethod = HTTPMethod.post.rawValue
        mutableRequest.allHTTPHeaderFields = headers
        let session = URLSession.shared
        
        task = session.uploadTask(with: mutableRequest, from: bodyData, completionHandler: { (data, response, error) in
            guard let httpResopnse = response as? HTTPURLResponse else {
                failure?(data, error as? NSError, 0)
                return
            }
            if let error = error {
                failure?(data, error as NSError, httpResopnse.statusCode)
            }
            
            if self.successCodes.contains(httpResopnse.statusCode) {
                success?(data)
            } else if self.failedCodes.contains(httpResopnse.statusCode) {
                failure?(data, error as? NSError, httpResopnse.statusCode)
            } else {
                let info = [NSLocalizedDescriptionKey: "Request failed with code \(httpResopnse.statusCode))",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or Duer bug"]
                let error = NSError(domain:"DuerNetWorkService", code:0, userInfo: info)
                failure?(data, error, httpResopnse.statusCode)
            }
        })
        
        task?.resume()
    }
    
    
    func makeRequest(for url:URL,
                     method: HTTPMethod,
                     paramerType: ParamerType,
                     params: [String:Any]? = nil,
                     headers:[String:String]? = nil,
                     success:((Data?) -> Void)? = nil,
                     failure: ((_ data: Data?, _ error: NSError?, _ responseCode: Int) -> Void)? = nil) {
        var mutableRequest = makeQuery(for: url, params: params, type: paramerType)
        mutableRequest.allHTTPHeaderFields = headers
        mutableRequest.httpMethod = method.rawValue
        
        let session = URLSession.shared
        
        task = session.dataTask(with: mutableRequest, completionHandler: { (data, response, error) in
            guard let httpResopnse = response as? HTTPURLResponse else {
                failure?(data, error as? NSError, 0)
                return
            }
            
            if let error = error {
                failure?(data, error as NSError, httpResopnse.statusCode)
            }
            
            if self.successCodes.contains(httpResopnse.statusCode) {
                success?(data)
            } else if self.failedCodes.contains(httpResopnse.statusCode) {
                failure?(data, error as? NSError, httpResopnse.statusCode)
            } else {
                let info = [NSLocalizedDescriptionKey: "Request failed with code \(httpResopnse.statusCode))",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or Duer bug"]
                let error = NSError(domain:"DuerNetWorkService", code:0, userInfo: info)
                failure?(data, error, httpResopnse.statusCode)
            }
        })
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    // MARK: private method
    
    func makeQuery(for url: URL, params: [String:Any]?, type: ParamerType) -> URLRequest {
        switch type {
        case .json:
            var mutableRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval:10.0)
            if let params = params {
                mutableRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            }
            return mutableRequest
        case .path:
            var query = ""
            params?.forEach({ (key,value) in
                query += "\(key)=\(value)&"
            })
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            return URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval:10.0)
        }
    }
}
