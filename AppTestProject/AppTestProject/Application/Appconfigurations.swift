//
//  Appconfigurations.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/10.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

final class AppConfiguration {
    
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()

}
