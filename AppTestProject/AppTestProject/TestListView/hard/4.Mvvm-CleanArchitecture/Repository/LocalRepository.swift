//
//  LocalRepository.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/02.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

protocol LocalRepository { // }:AppDataServiceProtocol,MemeDataServicePorotocol, UserDefaultServiceProtocol  {
    func setIsLogin(_ loginStatus: Bool)
    func getIsLogin() -> Bool
    
    func setLoginType(type loginType: Int)
    func getLoginType() -> Int

    func setIsStartPush(_ pushValue: Bool)
    func getIsStartPush() -> Bool

    func setIsStartByOtherApp(_ startValue: Bool)
    func getIsStartByOtherApp() -> Bool
    
    func setDataParam(param: [String:Any])
    func getDataParam() -> [String:Any]?
    
    
}

class LocalRepositoryImpl: LocalRepository {
    
    var appData = AppDataService()
    let memData = MemDataService.shared
    var preference = UserDefaults()
    
    func setIsLogin(_ loginStatus: Bool) { memData.isLogin = loginStatus }
    func getIsLogin() -> Bool { return memData.isLogin }
    
    func setLoginType(type loginType: Int) { memData.loginType = loginType }
    func getLoginType() -> Int { return memData.loginType }

    func setIsStartPush(_ pushValue: Bool) { memData.isStartPush = pushValue}
    func getIsStartPush() -> Bool { return memData.isStartPush }

    func setIsStartByOtherApp(_ startValue: Bool) { memData.isStartByOtherApp = startValue }
    func getIsStartByOtherApp() -> Bool { return memData.isStartByOtherApp }
    
    func setDataParam(param: [String:Any]) { memData.dataParam = param }
    func getDataParam() -> [String:Any]? { return memData.dataParam ?? nil }
}

