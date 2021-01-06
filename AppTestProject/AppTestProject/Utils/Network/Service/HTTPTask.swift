//
//  HTTPTask.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/06.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]


/// 내부 배치 서비스 그룹.
public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
    case download
    case upload
    // .. etc
    
}
