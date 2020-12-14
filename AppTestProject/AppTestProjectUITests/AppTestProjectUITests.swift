//
//  AppTestProjectUITests.swift
//  AppTestProjectUITests
//
//  Created by Kyung Shik Kim on 2020/12/11.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import XCTest
import AppTestProject

// Given : 주어진 환경
// When : 행위
// Then : 기대결과

class AppTestProjectUITests: XCTestCase {
    
    override func setUpWithError() throws {
        print("setUpWithError")
        // 여기에 설정 코드를 입력하세요. 이 메서드는 클래스의 각 테스트 메서드를 호출하기 전에 호출됩니다.

        // UI 테스트에서는 일반적으로 실패가 발생하면 즉시 중지하는 것이 가장 좋습니다.
        // 계속 실행을 원한다면 true
        continueAfterFailure = false

//        app.launch() // 앱실행

        // UI 테스트에서는 테스트가 실행되기 전에 필요한 초기 상태 (예 : 인터페이스 방향)를 설정하는 것이 중요합니다. setUp 메서드는이 작업을 수행하기에 좋은 장소입니다.
        
    }

    override func tearDownWithError() throws {
        print("tearDownWithError")
        // 여기에 분해 코드를 넣으십시오. 이 메서드는 클래스의 각 테스트 메서드를 호출 한 후에 호출됩니다.
    }

    func testExample() throws {
        // UI 테스트는 테스트하는 애플리케이션을 시작해야합니다.
        
        // test를 위한 UIApplication
        // XCUIApplication : 앱을 실행 및 종료할 수 있는 앱의 "프록시"
        let app = XCUIApplication()
        app.launch()

        // 레코딩을 사용하여 UI 테스트 작성을 시작하십시오.
        // XCTAssert 및 관련 함수를 사용하여 테스트가 올바른 결과를 생성하는지 확인합니다.
        print("testExample")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // 이는 애플리케이션을 시작하는 데 걸리는 시간을 측정합니다.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_UIRecording_Tutorial() {
        
    }
}
