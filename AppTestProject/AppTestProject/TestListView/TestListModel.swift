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
let hardTestList:[String] = ["👨🏻‍💻wkwebview - script(💬)",
                             "👨🏻‍💻mvvm-simple",
                             "👨🏻‍💻mvvm(rxswift)",
                             "👨🏻‍💻Autolayout",
                             "👨🏻‍💻Network"]

let normalTestList:[String] = ["👨🏻‍💻wkwebview - basic(💬)",
                               "👨🏻‍💻enum",
                               "👨🏻‍💻String test",
                               "👨🏻‍💻ContainerView"]
