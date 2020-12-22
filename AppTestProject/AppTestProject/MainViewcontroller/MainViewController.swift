//
//  MainViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/11.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit
import Lottie
class MainViewController: UIViewController {

    @IBOutlet var submitBtn: UIButton!
    @IBOutlet weak var btnShared: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.resultLabel.accessibilityIdentifier = "result-label"
        self.inputField.accessibilityIdentifier = "input-field"
        self.submitBtn.accessibilityIdentifier = "submit-button"
        self.btnShared.accessibilityIdentifier = "shareBtn"
        
        // Color.xcassets 지원버전 iOS 11.0
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                // system mode : dark
                print("system display mode : dark")
            }else{
                // system mode : light
                print("system display mode : light")
            }
        }else{
            // iOS 13 버전 미만
            // system mode : light
            print("system mode : light")
        }
        // OpenSource swiftGen
        // Color.xcassets의 커스텀 색상 사용 : 코드와 인터페이스 빌더에서 모두 사용가능, 단 개발 단계에서 오류 인지가 어렵다(오타...등등)
        // SwiftGen(OpenSource)빌드단계에서 자동으로 코드로 생성(script로 swift파일로 만들어줌)
        // 설치방법 : CocoaPods, homebrew로 시스템 전체설치 가능
        // brew update
        // brew install swift gen
        // url : https://github.com/SwiftGen/SwiftGen
        //       https://zeddios.tistory.com/1017?category=682196
        submitBtn.backgroundColor = Asset.customBlue.color
        
//        view.backgroundColor = UIColor.systemBackground // ios12이하에서 지원하지 못해 extension 추가.
//        view.backgroundColor = AssetColor.systemBackground // Extension 참고.
    }
    
    
    // 외부 공유하기
    // url : https://www.swiftdevcenter.com/uiactivityviewcontroller-tutorial-by-example/
    @IBAction func doShare(_ sender: Any){
        let shareText: String = "share text string"
        var shareObject = [Any]()
        shareObject.append(shareText)
        let activityViewController = UIActivityViewController(activityItems: shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        //Completion handler
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print("share completed")
                return
            } else {
                print("cancel")
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
    }
    @IBAction func actionLabel(_ sender: Any){
        print("actionLabel")
    }
    


}

