//
//  ToastMessage.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/15.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit
import Toaster

class ToastMessage {
//    static func Message(str:String, bottomOffset: CGFloat? = nil) {
//        ToastView.appearance().backgroundColor = UIColor(named: "dark_grey_1")?.withAlphaComponent(0.8)
//        ToastView.appearance().cornerRadius = 16
//        ToastView.appearance().font = UIFont.whiteMedium14PtLeft
//
//        if let offset = bottomOffset {
//            ToastView.appearance().bottomOffsetPortrait = offset
//        }
//
//        ToastCenter.default.cancelAll()
//        Toast(text: str, delay: 0, duration: 10).show()
//    }
    static func Message(str:String, duration: Double? = nil) {
//        ToastView.appearance().backgroundCol2.0or = UIColor(named: "dark_grey_1")?.withAlphaComponent(0.8)
        ToastCenter.default.cancelAll()
        Toast(text: str, delay: 0.0, duration: duration ?? 2.0).show()
    }
}
