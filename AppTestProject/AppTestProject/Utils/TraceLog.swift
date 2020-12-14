//
//  TraceLog.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/14.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import Foundation
/// TRACELog
/// - Parameters:
///   - filename: 파일명
///   - line: line
///   - funcname: 함수이름
func TRACE_LOG(filename: String = #file, line: Int = #line, funcname: String = #function) {
//    print("\(filename)[\(funcname)][Line \(line)]")
    let now = NSDate()
    print("[\(now.description)::\((filename as NSString).lastPathComponent) - \(funcname)[Line : \(line)]]")
}

func TRACE_LOG_PRINT(filename: String = #file, line: Int = #line, funcname: String = #function, output:Any...) {
    let now = NSDate()
    print("[\(now.description)][\(filename)][\(funcname)][Line \(line)] \(output)")
}
