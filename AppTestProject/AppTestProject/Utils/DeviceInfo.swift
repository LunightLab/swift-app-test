//
//  DeviceInfo.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/23.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import Foundation
import Darwin
import CoreTelephony
import UIKit

/// 통신사 정보 가져오기
/// - Returns: 통신사 정보 Dictionary
func getTelephoneInfo() -> Dictionary<String,Any> {

    var resultTelephoneInfo = [String:Any]()
    
    if checkSimCard(){
    
        // Setup the Network Info and create a CTCarrier object
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        // Get carrier name
        resultTelephoneInfo["ERROR"] = "0"
        resultTelephoneInfo["Carrier name"] = carrier?.carrierName
        resultTelephoneInfo["Mobile Country Code"] = carrier?.mobileCountryCode
        resultTelephoneInfo["Mobile Network Code"] = carrier?.mobileNetworkCode
        resultTelephoneInfo["ISO Country Code"] = carrier?.isoCountryCode
        
        if carrier!.allowsVOIP{
            resultTelephoneInfo["Allows VOIP"] = true
        }else{
            resultTelephoneInfo["Allows VOIP"] = false
        }

    }else{
        resultTelephoneInfo["ERROR"] = "ERROR=NOT_FOUND_SIMCARD"
    }
    return resultTelephoneInfo
}

/// 디바이스 USIM check
/// - Returns: 유심유무 Bool
func checkSimCard() -> Bool {
    
    let simInfo = CTTelephonyNetworkInfo()
    if let carrier = simInfo.subscriberCellularProvider{
        if let code = carrier.mobileNetworkCode{
            if !code.isEmpty{
                return true
            }
        }
    }
    return false
}

/// 디바이스 코드
/// - Description : 디바이스 고유 number 코드값을 가져옴 ex.) iPhone9,3
///   - ref : https://en.wikipedia.org/wiki/List_of_iOS_and_iPadOS_devices
/// - Returns: 디바이스 코드 String
func getDeviceModelCode() -> String {
    
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let modelCode = withUnsafePointer(to: &systemInfo.machine){
        $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
    } ?? "not found code"
    
    print("📱 Device model : ", modelCode)
    return modelCode
}

/// iOS 버전 구하기
/// - Returns: OS 버전 String
func getOsVersion() -> String {
    let os = ProcessInfo().operatingSystemVersion
    return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
}


/// 앱 버전
/// - Returns: App 버전 String
func getAppVersion() -> String {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    let build = dictionary["CFBundleVersion"] as! String
    return version + "(" + build + ")"
}

/// 앱 이름 정보를 가져온다.
/// - Returns: App display name return String
func getAppName() -> String {
    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    return appName
}

/// 고유한 번호(UUID)를 구한다.
/// - Returns: UUID String
func getDeviceUniqueCode() -> String{
    let deviceUUID = UIDevice.current.identifierForVendor?.uuid
    let deviceVendorID = UIDevice.current.identifierForVendor?.uuidString ?? "nil"
    dump(deviceUUID)
    dump(deviceVendorID)
    return deviceVendorID
}


func getDeviceModel() -> String {
    return UIDevice.current.model
}


/// 디바이스 타입을 번환한다.
///  - Description : iphone 인지 pad인지 번환
/// - Returns: Device type String
func getDeviceType() -> String {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone ? "phone" : "pad"
}

/// 언어정보 가져오기
/// - Returns: 언어코드 String
func getLanguageCode() -> String {
    let languagePrefix = Locale.preferredLanguages[0]
    return languagePrefix
}
