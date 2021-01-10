//
//  MainViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/11.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit
import Lottie
import OSLog

protocol MainViewControllerProtocol {
    var viewModel: MainViewModel { get set }
    func MainVCconfigure()
}

class MainViewController: UIViewController, MainViewControllerProtocol, UITextFieldDelegate {

    var viewModel = MainViewModel()
    

    @IBOutlet weak var naviTitle: UILabel!   // 네비게이션 Title
    @IBOutlet weak var btnNextView: UIButton! // swift 테스트 리스트 테이블 뷰 호출
    @IBOutlet weak var txtFieldLog: UITextView! // logView
    

    
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet weak var btnShared: UIButton!
    @IBOutlet weak var inputField: UITextField!
    
    // lazy closure UILabel
    lazy var lazyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    // MARK: -
    // MARK: View LiftCycle functions
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.addSubview(lazyLabel)
        // view setting
        MainVCconfigure()
        
        //os_log test function
//        testOS_LogAndLogger()
        
        // get device info call function
        getUserInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: -
    // MARK: Delegate
    
    // UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    // UIResponder 앱 이벤트처리 클래스
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    // MARK: -
    func MainVCconfigure() {
        
        // UITest accessibilityIdentifier 설정
//        self.inputField.accessibilityIdentifier = "input-field"
//        self.submitBtn.accessibilityIdentifier = "submit-button"
//        self.btnShared.accessibilityIdentifier = "shareBtn"
//
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
        
                
        btnNextView.backgroundColor = Asset.defaultBackground.color
        btnNextView.layer.borderColor = viewModel.titleColor.cgColor
        btnNextView.layer.borderWidth = 2.0
        btnNextView.setTitleColor(viewModel.titleColor, for: .normal)
        btnNextView.setTitleColor(viewModel.titleColor, for: .highlighted)
        btnNextView.setTitle(viewModel.btnNextViewNormalName, for: .normal)
        btnNextView.setTitle(viewModel.btnNextViewHighlightName, for: .highlighted)
        
        submitBtn.backgroundColor = Asset.defaultBackground.color
        submitBtn.layer.borderColor = viewModel.titleColor.cgColor
        submitBtn.layer.borderWidth = 2.0
        submitBtn.setTitleColor(viewModel.titleColor, for: .normal)
        submitBtn.setTitleColor(viewModel.titleColor, for: .highlighted)
        
        
    }
    
    func getUserInfo() {
        
        // simcard check & 통신사 정보확인
        if checkSimCard() {
            let celphoneInfo = getTelephoneInfo() // 심카드 체크
            dump(celphoneInfo)
        }else{
            
        }
        // get device model
        dump(getDeviceModelCode())
        
        // get OS version
        dump(getOsVersion())
        // get App version
        dump(getAppVersion())
        
        // get App name
        dump(getAppName())
        
        // get device unique code
        dump(getDeviceUniqueCode())
        
        dump(getDeviceType())
        
        dump(getLanguageCode())
    }
    
    func testOS_LogAndLogger() {
        // MARK: os_log & Logger(ios14이상) 테스트..
        // FIXME: 추가 테스트 필요함.
        // iOS 14이상 API 추가 Logger
        if #available(iOS 14.0, *) {
            Logger.viewCycle.info("viewInfomation")
            Logger.viewCycle.debug("User debug")
//            Logger.viewCycle.debug("User \(username, privacy: .private) logged in")
        } else {
            // Fallback on earlier versions
            os_log("View did load!", log: OSLog.viewCycle, type: .info)
            os_log("View error", log:OSLog.getData, type: .error)
    //        os_log("User %{public}@ logged in", log: OSLog.userFlow, type: .info, username)
    //        os_log("User %{private}@ logged in", log: OSLog.userFlow, type: .info, username)
        }
        os_log("View did load!", log: OSLog.viewCycle, type: .info)
        os_log("View error", log:OSLog.lunigtLab, type: .error)
        
    }
    // MARK: -
    
    // 외부 공유하기
    // MARK: 외부 공유하기
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
    
    @IBAction func showNextView(_ sender: Any) {
        viewModel.moveHandler(){ isSuccess in
            if isSuccess {
                print("\(#function)::move sample second")
                guard let webvc = self.storyboard?.instantiateViewController(withIdentifier: "TestListViewController") else {
                    return
                }
                webvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                webvc.modalPresentationStyle = .fullScreen
                self.present(webvc, animated: true)
            }
        }
    }
}

