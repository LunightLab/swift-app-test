//
//  NetworkService.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/07.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation
import UIKit

typealias ResponseJson = ((_ result:[String:Any]?, _ error:Error?) -> Void)
typealias ResponseString = ((_ result:String?, _ error:Error?) -> Void)
typealias ResponseData = ((_ result:Data?, _ error:Error?) -> Void)

// URLSessionDelegate: 세션 수명주기 변경과 같은 세션 수준 이벤트 처리를 위함.
class SessionDelegate:NSObject, URLSessionDelegate {
    
    /// [인증처리] 원격 서버의 세션 인증요청에 대한 응답으로 자격증명을 요청
    /// - Parameters:
    ///   - session: 인증요청이 포함된 세션
    ///   - challenge: 인증 요청이 포함된 개체
    ///   - completionHandler: disposition : 첼린지 처리방법, redentail : 인증에 사용해야하는 자격증명
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.previousFailureCount > 0 {
            completionHandler(.cancelAuthenticationChallenge, nil)
        } else {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }
    
    /// [인증처리] 원격 서버의 세션 인증요청에 대한 응답으로 자격증명을 요청
    /// - Parameters:
    ///   - session: 인증요청이 포함된 세션
    ///   - task: 요청에 인증이 필요한 작업
    ///   - challenge: 인증 요청이 포함된 개체
    ///   - completionHandler: disposition : 첼린지 처리방법, redentail : 인증에 사용해야하는 자격증명
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!))
    }
}

class Network: NSMutableURLRequest {
    
    private static var showLoadingRequests = NSMutableArray()
    private static var noneLoadingRequests = NSMutableArray()
    private static let dispatchQueue = DispatchQueue(label: "network queue")
    
    private static let delegate: SessionDelegate = {
        let d = SessionDelegate()
        return d
    }()
    
    init(sendURL: URL){
        super.init(url: sendURL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 30)
        self.initSetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:  coder)
    }
    
    func initSetting() {
        self.allHTTPHeaderFields = self.httpHeader
        self.httpMethod = "POST"
        self.setValue("application/json", forKey: "Content-Type")
    }
    
    let httpHeader:[String:String] = {
        var header:[String:String] = [:]
        // header["User-Agent"] = HybridWebView.customUserAgent
        return header
    }()
    
    var param:[String:Any]? {
        didSet {
            self.httpBody = nil
            self.setValue(nil, forHTTPHeaderField: "Content-Type")
            self.httpMethod = "POST"
            
            if let param = self.param, let jsonData : Data = try? JSONSerialization.data(withJSONObject: param as Any, options: []) {
                self.httpBody = jsonData
                self.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            self.addValue(String(format: "%d", self.httpBody?.count ?? 0), forHTTPHeaderField: "Content-Length")
        }
    }
    
    var paramString: String? {
        didSet {
            self.httpBody = nil
            self.httpMethod = "POST"
            
            if let param = self.paramString, let paramData : Data = param.data(using: .utf8) {
                self.httpBody = paramData
                self.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            self.addValue(String(format: "%d", self.httpBody?.count ?? 0), forHTTPHeaderField: "Content-Length")
        }
    }
    
    var wait = false
    var runLoop = false
    var setKeppAlive = false
    var showLoading = false
    
    var own:Any?
    
    var responseJson : ResponseJson?
    var responseString : ResponseString?
    var responseData : ResponseData?
    
    class func send(url:String? = nil,
                    pageId:String? = nil,
                    param:[String:Any]? = nil,
                    paramString:String? = nil,
                    wait:Bool = false,
                    loading:Bool = false,
                    responseJson : ResponseJson? = nil,
                    responseString : ResponseString? = nil,
                    responseData : ResponseData? = nil) {
        
        let urlString:String? = url ?? self.makeUrl(pageId)
        
        if let sendUrlString = urlString, let sendURL = URL(string: sendUrlString) {
            let req = Network(sendURL: sendURL)
            req.param = param
            req.paramString = paramString
            req.wait = wait
            req.showLoading = loading
            req.responseJson = responseJson
            req.responseString = responseString
            req.responseData = responseData
            req.send()
        }
    }
    private class func makeUrl(_ pageId: String?) -> String? {
        
        return nil
    }
    
    func send() {
        if setKeppAlive {
            self.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
            self.setValue("600", forHTTPHeaderField: "Keep-Alive")
        } else {
            self.setValue(nil, forHTTPHeaderField: "Connection")
            self.setValue(nil, forHTTPHeaderField: "Keep-Alive")
        }
        Network.regist(self)
        self.perform(#selector(sendData), on: .main, with: nil, waitUntilDone: wait)
    }
    @objc func sendData(){
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: Network.delegate, delegateQueue: nil)
        let task = session.dataTask(with: self as URLRequest) { (data, response, error) in
            if let allHeaderFields = (response as? HTTPURLResponse)?.allHeaderFields as? [String : String], let url = response?.url  {
                let cookies:[HTTPCookie] = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFields, for: url)
                for cookie in cookies {
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }
            if error == nil {
                self.perform(#selector(self.requestFinished(_:)), on: .main, with: data, waitUntilDone: false)
            } else {
                self.perform(#selector(self.requestFail(_:)), on: .main, with: error as NSError?, waitUntilDone: false)
            }
        }
        task.resume()
        if wait {
            self.runLoop = true
            while self.runLoop == true {
                RunLoop.current.acceptInput(forMode: RunLoop.Mode.default, before: RunLoop.current.limitDate(forMode: RunLoop.Mode.default) ?? NSDate.distantFuture)
            }
        }
    }
    @objc func requestFinished(_ data:Data?) {
        
        if responseData != nil {
            self.responseData?(data,nil)
        }
        
        if responseString != nil {
            self.responseString?(String(data: data ?? Data(), encoding: .utf8),nil)
        }
        
        if responseJson != nil {
            if let resultData = data, let jsonObj = try? JSONSerialization.jsonObject(with: resultData) as? [String:Any]{
                self.responseJson?(jsonObj,nil)
            }
        }
        
        self.runLoop = false
        Network.remove(self)
    }
    @objc func requestFail(_ error:NSError?) {
        self.responseString?(nil,error)
        self.responseJson?(nil,error)
        self.responseData?(nil,error)
        self.runLoop = false
        Network.remove(self)
    }
    
    @objc class func regist(_ request:Network) {
        Network.dispatchQueue.sync {
            if request.showLoading {
                Network.showLoadingRequests.add(request)
            } else {
                Network.noneLoadingRequests.add(request)
            }
            
            if Network.showLoadingRequests.count != 0 {
//                Indicator.show()
            }
        }
    }
    
    @objc class func remove(_ request:Network) {
        Network.dispatchQueue.sync {
            if request.showLoading {
                Network.showLoadingRequests.remove(request)
            } else {
                Network.noneLoadingRequests.remove(request)
            }
            
            if Network.showLoadingRequests.count == 0 {
//                Indicator.hide()
            }
        }
    }
}
