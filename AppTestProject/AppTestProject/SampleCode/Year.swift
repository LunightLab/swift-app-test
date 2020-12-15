//
//  Year.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/11.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import Foundation

/*
 윤년 계산
 400으로 나누어 떨어지는 해는 윤년,
 100으로 나누어 떨어지지 않고 4로 나누어 떨어지는 해도 윤년.
 */
struct Year {
    let calenderYear: Int
    var isLeapYear: Bool {
        get {
            return calenderYear%4 == 0 && ( calenderYear%100 != 0 || calenderYear%400 == 0)
        }
    }
}
