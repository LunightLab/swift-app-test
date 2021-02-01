//
//  SwiftKeyChainWrapperViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/02/01.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

enum ChainKeyList: String {
    case uuid = "device-uuid"
}
class SwiftKeyChainWrapperViewController: UIViewController {
    
    // MARK: -
    // MARK: View LiftCycle functions
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(UIDevice.current.model)
        print("modelvendor : \(SwiftKeyChainWrapperViewController.getModelVendor() ?? "")")
       // iPhone2D92C8EC-103B-4161-B078-573AD9B8E70A
        // MARK: Custom Instance
        // custom instance는 여길 참고 (https://evgenii.com/blog/sharing-keychain-in-ios/)
        //        let serviceName = "lab.lunightlab.AppTestProject"
        //        let shareGroup = "lab.lunightlab.AppTestProjectGroup"
        //
        //        let customKeychainWrapperInstance:KeychainWrapper = KeychainWrapper(serviceName: serviceName, accessGroup: shareGroup)
        //
        //        if customKeychainWrapperInstance.hasValue(forKey: ChainKeyList.uuid.rawValue) {
        //
        //            print("custom instance find key : " + customKeychainWrapperInstance.string(forKey: ChainKeyList.uuid.rawValue)!)
        //
        //        }else{
        //            print("??")
        //
        //
        //            if customKeychainWrapperInstance.set(getDeviceUniqueCode(), forKey: ChainKeyList.uuid.rawValue) {
        //                if let id = customKeychainWrapperInstance.string(forKey: ChainKeyList.uuid.rawValue) {
        //                    print("save uuid : \(id)")
        //                }
        //            }else{
        //                print("custom")
        //            }
        //        }
    }
    
    /// OS 버전에 따른 기기 유니크값 구하기
    /// device model  + vendoruuid 문자열 값을 키체인에 저장하고 그 값을 가져온다.
    /// - Returns: devicemodel + uuid
    static func getModelVendor() -> String! {
        
        if let getModelUuid = KeychainWrapper.standard.string(forKey: kSecAttrAccount as String){
            return getModelUuid
        }else{
            //        let deviceUUID = UIDevice.current.identifierForVendor?.uuid
            let deviceVendorID = UIDevice.current.identifierForVendor?.uuidString ?? "nil"
            let deviceModel = UIDevice.current.model
            KeychainWrapper.standard.set(String(deviceModel + deviceVendorID), forKey: kSecAttrAccount as String)
            return KeychainWrapper.standard.string(forKey: kSecAttrAccount as String)
        }
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
    @IBAction func btnBack(_ sender: Any) {
        print("back")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
