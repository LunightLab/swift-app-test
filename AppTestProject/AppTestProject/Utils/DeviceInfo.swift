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

/**
 통신사 정보 가져오기
 
 @return 통신사 정보
 */
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

/**
통신사 정보 가져오기
@return 유심유무 체크
*/
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

