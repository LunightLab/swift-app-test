//
//  UserDefaultService.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/02.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

protocol PreferenceServiceProtocol {
    
}

class preferenceService: PreferenceServiceProtocol {
    
    let userdefaults = UserDefaults.standard
    let mainBundle =  Bundle.main
    
    func setValue<T>(value: T, key: String) {
        
    }
    //    func getString
    func set<T>(value: T , key: String) {
        userdefaults.set(value, forKey: key)
        self.synchronize()
    }
    
    func getValue(key: String) -> Any{
        return userdefaults.object(forKey: key) as Any
    }
    
    
    /// 키에 해당하는 데이터 삭제
    /// - Parameter key: 키
    func remove(key: String) {
        userdefaults.removeObject(forKey:key)
        self.synchronize()
    }
    
    /// UserDefaults에 저장된 모든 사용자  데이터 제거
    func clearUserData() {
        if let bundleId = mainBundle.bundleIdentifier {
            userdefaults.removeVolatileDomain(forName: bundleId)
            self.synchronize()
        }
        
    }
    
    /// UserDefaults에 저장된 모든 데이터 제거(앱초기화)
    func clearAppData() {
        if let bundleId = mainBundle.bundleIdentifier {
            userdefaults.removePersistentDomain(forName: bundleId)
            self.synchronize()
        }
    }
    
    /// 동기화 처리
    private func synchronize(){
        userdefaults.synchronize()
    }
    
}
