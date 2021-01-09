//
//  SimpleMvvmViewModel.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/04.
//  Copyright © 2021 lunightlab. All rights reserved.
//

/**
  # Q. sample code : 계산기?
 */
import UIKit

protocol SimpleMvvmProtocol {
    var title: String { get }
    var fontColor: UIColor { get }
    var btnResultNormalName: String? { get }
    var btnResultHighlightName: String? { get }
    
    // navigation bar set
    var navibarBackgroundColor: UIColor? { get }
    var navibarIsTranlucent: Bool? { get }
    var clipsToBounds: Bool? { get }
}

public class SimpleMvvmVM: SimpleMvvmProtocol {
    
    
    public var title: String {
        return "👨🏻‍💻Simple Mvvm test"
    }
    
    public var fontColor: UIColor {
        return Asset.defaultTextColor.color
    }
    
    // FIXME: Asset 연결이 안됨;;;;
    var navibarBackgroundColor: UIColor? = .gray
    var navibarIsTranlucent: Bool? = false // navibar 기본이 반투명(true)상태임.
    var clipsToBounds: Bool? = true
    
    var btnResultNormalName: String? = " = "
    var btnResultHighlightName: String? = " 결과 "
    
    func handler(completion: @escaping (Bool) -> Void) {
        TRACE_LOG()
        print("\(#function):: success")
        completion(true)
    }
    
}
