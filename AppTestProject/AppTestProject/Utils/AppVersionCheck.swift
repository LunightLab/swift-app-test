//
//  AppVersionCheck.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/29.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import Foundation

func currentAppVersion() -> String {
    if let info: [String : Any] = Bundle.main.infoDictionary,
       let currentVersion: String = info["CFBundleShortVersionString"] as? String {
        return currentVersion
    }
    return "nil"
}

func currentBuildNumber() -> String {
    if let info: [String : Any] = Bundle.main.infoDictionary,
       let currentVersion: String = info["CFBundleVersion"] as? String {
        return currentVersion
    }
    return "nil"
}
