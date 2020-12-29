//
//  TestListModel.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/28.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import Foundation

enum HartTestList: String, CaseIterable {
    case testAutoLayout = "AutoLayout"
    static var count:Int { return  NormalTestList.allCases.count }
}
enum NormalTestList: String, CaseIterable{
    
    case testWkwebView = "wkwebview"
    static var count:Int { return  NormalTestList.allCases.count }
}

let normalTestList:[String] = ["enum", "String test"]
let hardTestList:[String] = ["wkwebview","Autolayout"]
