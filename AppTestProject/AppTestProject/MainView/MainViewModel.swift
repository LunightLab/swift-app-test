//
//  MainViewModel.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/24.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit

protocol MainViewProtocol {
    var title:String { get }
    var titleColor: UIColor { get }
    var btnNextViewNormalName: String? { get }
    var btnNextViewHighlightName: String? { get }
    func moveHandler(completion:@escaping (Bool) -> Swift.Void)
}

public class MainViewModel: MainViewProtocol {
    
    public var title: String {
        return "Sample Test board"
    }
    public var titleColor: UIColor {
        return Asset.defaultTextColor.color // Asset.DefaultTextColor.color
    }
    
    var btnNextViewHighlightName: String? = "이동합니다."
    var btnNextViewNormalName: String? = " Swift test list  "
    
    func moveHandler(completion: @escaping (Bool) -> Void) {
        print("\(#function)::success, move sample view")
        completion(true)
    }
    
}
