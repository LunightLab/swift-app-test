//
//  AppAppearance.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/10.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {

// tintColor면 navigation items과 bar button items에 적용
//        navibar.tintColor = viewModel.fontColor
//        navibar.barTintColor = viewModel.navibarBackgroundColor

        UINavigationBar.appearance().tintColor = Asset.defaultTextColor.color
        UINavigationBar.appearance().barTintColor = Asset.navigationBarBackground.color
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    }
}
