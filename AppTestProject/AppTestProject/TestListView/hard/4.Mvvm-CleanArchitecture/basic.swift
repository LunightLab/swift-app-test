//
//  basic.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/03/02.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation


// https://www.debugcn.com/ko/article/20288184.html

// Service Locator declaration
// Type-safe and completely rigid.

//protocol ServiceLocator {
//    var s1: S1? { get set }
//    var s2: S2? { get set }
//}
//
//final class NaiveServiceLocator: ServiceLocator {
//    var s1: S1?
//    var s2: S2?
//}
//
//// Service Locator declaration
//// Type-safe and completely rigid.
//
//protocol LocalRepository {
//    var s1: S1? { get set }
//    var s2: S2? { get set }
//}
//
//final class LocalRespositoryImpl: ServiceLocator {
//    var s1: S1?
//    var s2: S2?
//}
//
//
//// Services declaration
//protocol S1 {
//    func f1() -> String
//    var s1value: Int { get set }
//}
//// Services imlementation
//class S1Impl: S1 {
//    var s1value = 1
//    func f1() -> String {
//        return "S1 OK"
//    }
//}
//
//// Services declaration
//
//protocol S2 {
//    func f2() -> String
//    var s2value: String { get set }
//}
//class S2Impl: S2 {
//    var s2value = ""
//    func f2() -> String {
//        return "S2 OK"
//    }
//}
//
//// Service Locator initialization
//
//let sl: ServiceLocator = {
//    let sl = NaiveServiceLocator()
//    sl.s1 = S1Impl()
//    sl.s2 = S2Impl()
//    return sl
//}()
//
//// Test run
//
//print(sl.s1?.f1() ?? "S1 NOT FOUND") // S1 OK
//print(sl.s2?.f2() ?? "S2 NOT FOUND") // S2 OK
//
//sl.s1?.s1value
