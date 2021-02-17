//
//  SimpleMvvmVC.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/04.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import UIKit
import OSLog

//protocol SimpleMvvmVCProtocol {
//
//    var viewModel: SimpleMvvmVM { get set }
//
//}
 
class SimpleMvvmVC: UIViewController {
    
    var viewModel = SimpleMvvmVM()
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var navibar: UINavigationBar!
    
    // MARK: -
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        
        // MARK: os_log
        // https://zeddios.tistory.com/979
        
        // iOS 10.0이상
        // FIXME: os_log iOS 10.0 미만 버전 확인필요.
        if #available(iOS 10.0, *) {
        os_log("viewDidLoad", log: OSLog.viewCycle , type: .info)
        }

        os_log("Logger default", log: OSLog.viewCycle, type: .default)
        os_log("Logger debug", log: OSLog.viewCycle, type: .debug)
        os_log("Logger error", log: OSLog.viewCycle, type: .error)
        os_log("Logger fault", log: OSLog.viewCycle, type: .fault)
        
        if #available(iOS 14.0, *) {
            os_log("Logger 예외처리", log: OSLog.disable, type: .default)
            Logger.viewCycle.fault("\(#function)")
        } else {
            // Fallback on earlier versions
            os_log("Logger 예외처리", log: OSLog.disable, type: .error)
        }

    // os_log test
    // console.app에서 필터링 할 수 있음.
    //        let username: String = "lunight"
    //        os_log("User %{public}@ logged in", log: OSLog.default, type:.info, username)
    //        os_log("User %{private}@ logged in", log: OSLog.default, type:.info, username)

        super.viewDidLoad()
        viewConfigure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    // MARK: -
    // MARK: view default setting
    @IBAction func btnBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func viewConfigure() {

        os_log("viewCongifure", log: OSLog.setting, type: .default)
        
        navibar.topItem?.title = viewModel.title
        // tintColor면 navigation items과 bar button items에 적용
        navibar.tintColor = viewModel.fontColor

        navibar.barTintColor = viewModel.navibarBackgroundColor
        navibar.isTranslucent = viewModel.navibarIsTranlucent ?? true
        navibar.shadowImage = UIImage()
        
        // navibar와 view사이 라인을 없애고싶을때.
        navibar.setBackgroundImage(UIImage(), for: .default)
        navibar.clipsToBounds = viewModel.clipsToBounds ?? true


    }
}
