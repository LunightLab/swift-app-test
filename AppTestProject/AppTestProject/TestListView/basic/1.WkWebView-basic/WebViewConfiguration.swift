//
//  WebViewConfiguration.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/02/09.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import WebKit

// MARK: WKWebViewConfiguration Class

// WKWebViewConfiguration : 웹뷰 초기화에 사용하는 속성모음
// WKScriptMessageHandler : 프로토콜. 웹페이지에서 실행되는 JavaScript massag0e를 수신하는 방법 제공. 스크립트 메세지가 수신될 때
class WebViewConfiguration: WKWebViewConfiguration, WKScriptMessageHandler {
    
    // MARK: init
    override init() {
        super.init()
        webviewConfigurationSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        webviewConfigurationSetup()
    }
    
    func webviewConfigurationSetup() {
        
        if #available(iOS 13.0, *) {
            self.defaultWebpagePreferences.preferredContentMode = .mobile
        }
        
        // HTML5 미디어 활성화
        self.allowsInlineMediaPlayback = true
        // javascript가 사용자 작용없이 window 오픈가능여부
        self.preferences.javaScriptCanOpenWindowsAutomatically = true
        // javascript 활성화
        self.preferences.javaScriptEnabled = true
        
    }
    
    // MARK: WKScritpMessageHandler

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "iOSBridge" {
            // webAction
        } else {
            #if DEBUG
            if message.name == "onError" {
                // message.body
            }
            #endif
        }
    }
    
}

// MARK: WebView 설정 Class

class WebViewSettings {
    /**
     @property cachePolicy
     @brief 웹뷰 기본 캐쉬 정책
    */
    static var cachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    /**
     @property timeout
     @brief 웹뷰 Request Timeout
    */
    static var timeout:TimeInterval = 30
    
    /**
     @property customViewport
     @brief 커스텀 뷰포트 사용여부 - 초기화 기본값
    */
    static var customViewport = true
    /**
     @property scalesPageToFit
     @brief viewPort 화면확대 여부 - 초기화 기본값
    */
    static var scalesPageToFit = true
    /**
     @property calloutEnabled
     @brief 롱프레스 콜아웃 사용여부 - 초기화 기본값
    */
    static var calloutEnabled = false
    /**
     @property selectEnabled
     @brief 텍스트및 영역 선택 사용여부 - 초기화 기본값
    */
    static var selectEnabled = false
    /**
     @property tabBarScroll
     @brief 하단 탭바 스크롤방향으로 hidden여부 - 초기화 기본값
    */
    static var tabBarScroll = true
    /**
     @property scrollBounces
     @brief 스크롤 바운스 여부
    */
    static var scrollBounces = false
    
    /**
     @property customViewport
     @brief 커스텀 뷰포트 사용여부
    */
    var customViewport = WebViewSettings.customViewport
    /**
     @property scalesPageToFit
     @brief viewPort 화면확대 여부
    */
    var scalesPageToFit = WebViewSettings.scalesPageToFit
    /**
     @property calloutEnabled
     @brief 롱프레스 콜아웃 사용여부
    */
    var calloutEnabled = WebViewSettings.calloutEnabled
    /**
     @property selectEnabled
     @brief 텍스트및 영역 선택 사용여부
    */
    var selectEnabled = WebViewSettings.selectEnabled
    /**
     @property tabBarScroll
     @brief 하단 탭바 스크롤방향으로 hidden여부
    */
    var tabBarScroll = WebViewSettings.tabBarScroll
    /**
     @property scrollBounces
     @brief 스크롤 바운스 여부
    */
    var scrollBounces = WebViewSettings.scrollBounces
}
