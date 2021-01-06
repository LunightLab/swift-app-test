//
//  HTTPMethod.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/06.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation


/// HTTP 프로토콜 enum type
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
