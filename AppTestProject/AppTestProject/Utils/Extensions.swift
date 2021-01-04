//
//  Extensions.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/14.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import Foundation
import UIKit
import os.log

typealias AssetColor = Asset

extension AssetColor {
    static var systemBackground: UIColor{
        if #available(iOS 13 , *) {
            return .systemBackground
        }
        return UIColor(displayP3Red: 222, green: 111, blue: 333, alpha: 1.0)
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like viewDidLoad.
    static let viewCycle = OSLog(subsystem: subsystem, category: "viewCycle")
    static let getData = OSLog(subsystem: subsystem, category: "data")
    static let disable = OSLog(subsystem: subsystem, category: "disable")
    static let lunigtLab = OSLog(subsystem: subsystem, category: "내가 체크한 로그")
}

@available(iOS 14.0, *)
extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
}


