//
//  LocalUseCase.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/02.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

 class LocalUseCase {
    
    private let localRepository: LocalRepository
    
    init (localRepository: LocalRepository) {
        self.localRepository = localRepository
    }

    func setIsLogin(status: Bool) { localRepository.setIsLogin(status) }
    func getIsLogin() -> Bool { return localRepository.getIsLogin() }
    
    func setLoginType(type: Int) { localRepository.setLoginType(type: type)}
    func getLoginType() -> Int { return localRepository.getLoginType() }

    func setIsStartPush(_ pushValue: Bool) { localRepository.setIsStartPush(pushValue)}
    func getIsStartPush() -> Bool { return localRepository.getIsStartPush() }

    func setIsStartByOtherApp(_ startValue: Bool) { localRepository.setIsStartByOtherApp(startValue)}
    func getIsStartByOtherApp() -> Bool { return localRepository.getIsStartByOtherApp() }
    
    func setDataParam(param: [String:Any]) { localRepository.setDataParam(param: param)}
    func getDataParam() -> [String:Any]? { return localRepository.getDataParam() }
    
}


