//
//  EndPointType.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/06.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation

/// 네트워크 계층 구현. 헤더, 쿼리 매개변수 및 본문 매개변수와 같은 구성요소를 모두 포함한 URLRequest
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
