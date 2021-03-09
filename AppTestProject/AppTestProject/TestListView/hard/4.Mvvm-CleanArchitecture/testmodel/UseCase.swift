//
//  UseCase.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/02.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

final class UserDefaultsInfoQueriesStore {
    
//    private let recentsQuesryKey = "key"
//    private var userDefaults: UserDefaults
//    private let mainBundle = Bundle.main
//    
//    init(userDefaults: UserDefaults = UserDefaults.standard) {
//        
//        self.userDefaults = userDefaults
//    }
//    
//    private func setRequestValue<T>(value: T, key: String) {
//        
//    }
//    private func setRequest<T>(value: T , key: String) {
//        userDefaults.set(value, forKey: key)
//    }
//    
//    
//    private func getRequest(key: String) -> Any{
//        return userDefaults.object(forKey: key) ?? ""
//    }
//    
//    
//    /// 키에 해당하는 데이터 삭제
//    /// - Parameter key: 키
//    private func removeRequest(key: String) {
//        userDefaults.removeObject(forKey:key)
//    }
//    
//    /// UserDefaults에 저장된 모든 사용자  데이터 제거
//    private func clearUserDataRequest() {
//        if let bundleId = mainBundle.bundleIdentifier {
//            userDefaults.removeVolatileDomain(forName: bundleId)
//        }
//        
//    }
//    
//    /// UserDefaults에 저장된 모든 데이터 제거(앱초기화)
//    private func clearAppDataRequest() {
//        if let bundleId = mainBundle.bundleIdentifier {
//            userDefaults.removePersistentDomain(forName: bundleId)
//        }
//    }
    
}

extension UserDefaultsInfoQueriesStore: PreferenceStorage {
    
    func setValue(completion: @escaping () -> Void) {
        
    }

}

protocol PreferenceStorage {
    
}
