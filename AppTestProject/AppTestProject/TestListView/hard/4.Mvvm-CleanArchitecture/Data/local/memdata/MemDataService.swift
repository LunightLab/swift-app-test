//
//  MemDataService.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/02.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

protocol MemeDataServicePorotocol {

}
final class MemDataService: MemeDataServicePorotocol {

    static let shared = MemDataService()
    
    private init() {
        print("MemDataService init")
    }
    
    // 로그인상태
    @objc var isLogin: Bool = false
//    func getIsLogin() -> Bool {
//        return isLogin
//    }
//    func setIsLogin(_ loginStatus: Bool) {
//        isLogin = loginStatus
//    }
    
    // 로그인 타입 (default:0 , id:1 , cert:2, sso:3 , simple : 5)loginType
    @objc var loginType: Int = 0
    
    // laguage
//    var localization: KBLanguage.Code = .Korean
    
    //Push에 의한 앱 기동인지 여부
    @objc var isStartPush:Bool = false
    
    // 앱 연동에 의한 구동인지
    @objc var isStartByOtherApp:Bool = false
    
    // 전문 통신후에 처리하기 위해 파라미터를 저장해놓음.
    @objc var dataParam:[String:Any]? = nil
    
}
