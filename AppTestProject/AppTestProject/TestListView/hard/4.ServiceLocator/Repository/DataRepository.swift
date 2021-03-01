//
//  DataRepository.swift
//  ServiceLocatorTest
//
//  Created by Kyung Shik Kim on 2021/02/28.
//

import Foundation

// 서비스 로케이터 선언
// 형식이 안전하고 완전히 고정
// Service Locator declaration
// Type-safe and completely rigid.

protocol ServiceLocator {
    var s1: S1Service? { get }
    var s2: S2Service? { get }
}

final class NaiveServiceLocator: ServiceLocator {
    
    static let shred = NaiveServiceLocator()
    
    private init() { print("singleton init()")}

    var s1: S1Service?
    var s2: S2Service?

}

