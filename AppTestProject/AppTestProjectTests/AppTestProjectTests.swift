//
//  AppTestProjectTests.swift
//  AppTestProjectTests
//
//  Created by Kyung Shik Kim on 2020/12/11.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import XCTest
@testable import AppTestProject

class AppTestProjectTests: XCTestCase {

    
    /// 초기화코드
    ///  여기에 설정 코드를 입력하세요. 이 메서드는 클래스의 각 테스트 메서드를 호출하기 전에 호출됩니다.
    /// - Throws: -
    override func setUpWithError() throws {
        TRACE_LOG()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    
    /// 해체코드
    /// 여기에 분해 코드를 넣으십시오. 이 메서드는 클래스의 각 테스트 메서드를 호출 한 후에 호출됩니다.
    /// - Throws: -
    override func tearDownWithError() throws {
        TRACE_LOG()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// 기능 테스트 케이스
    ///  XCTAssert 및 관련 함수를 사용하여 테스트가 올바른 결과를 생성하는지 확인합니다.
    /// - Throws: -
    func testExample() throws {
        TRACE_LOG()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // 이부분은 성능 테스트 사례의 예입니다.
        self.measure {
            // 여기에 시간을 측정하고 싶은 코드를 입력하세요.
        }
    }
    
    // 윤년 단위테스트
    func testVanillaLeapYesr() {
        let year = Year(calenderYear: 1996)
        XCTAssertTrue(year.isLeapYear)
    }
    func testAnyOldYear() {
        let year = Year(calenderYear: 1997)
        XCTAssertTrue(!year.isLeapYear)
    }
    func testCentury() {
        let year = Year(calenderYear: 1900)
        XCTAssertTrue(!year.isLeapYear)
    }
    func testExceptionalCentury() {
        let year = Year(calenderYear: 2400)
        XCTAssertTrue(year.isLeapYear)
    }
    
    func testUserDefault() {
        // MARK: mark
        // FIXME: ????
        // TODO: sonsole이 왜 안찍힘?
        let rvalue = "sample"
        UserDefaults.standard.set(rvalue, forKey: "rvaule") // save
        UserDefaults.standard.value(forKey: "rvalue") // load
        let userDefaults =  UserDefaults.standard
        if let getValue = userDefaults.value(forKey: "rvalue"){
            print("💬test : ", getValue)
        }
        userDefaults.removeObject(forKey: "rvalue") // remove
        UserDefaults.standard.value(forKey: "rvalue")
    }
}
