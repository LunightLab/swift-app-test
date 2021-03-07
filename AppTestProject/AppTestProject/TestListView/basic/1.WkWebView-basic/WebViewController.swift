//
//  WebViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/28.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit
import WebKit

// WKUIDelegate : JavaScript, 기타 플러그인 컨텐츠 이벤트를 캐치하여 동작. 기본 사용자 인터페이스 제공
// WKNavigationDelegate : 프로토콜. 페이지 start, loading, finish, error의 트리거 이벤트를 캐치하여 사용자 정의 동작을 구현
// WKScriptMessageHandler : 프로토콜. 웹페이지에서 실행되는 JavaScript massage를 수신하는 방법 제공. 스크립트 메세지가 수신될 때
// 호출하는 userContentController를 정의
class WebViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        TRACE_LOG()
        super.viewDidLoad()
        self.defaultRequest("http://www.naver.com")
//        initWebView_callFromJs()
        
    }
    
    /// WKScriptMessageHandler Callback (Javascript -> Native Call (Param))
    /// JS -> Native CALL
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler"){
            print(message.body)
            abc()
        }
    }
    
    func abc(){
        print("abc call")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        TRACE_LOG()
        super.viewDidAppear(true)
        checkNetworkDetect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func loadView() {
//        TRACE_LOG()
//        super.loadView()
//
//        self.view = self.webView
//    }
    func defaultRequest(_ url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
//        webView.uiDelegate = self
        self.webView.navigationDelegate = self

    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK : Web 인터페이스
    @IBAction func btnWebBack(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }else{
            // no back page
        }
    }
    
    @IBAction func btnForward(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }else{
            // no forward page
        }
    }
    
    @IBAction func btnRefloash(_ sender: Any) {
        print("reflash page")
        webView.reload()
    }
    
    @IBAction func btnGoHome(_ sender: Any) {
        print("go home")
        webView.load(URLRequest(url: URL(string: "")!))
    }
    
    // MARK: 네트워크 감지체크
    func checkNetworkDetect(){
        if Reachability.isConnectedToNetwork() {
            
        }else{
            let alert = UIAlertController(title: "네트워크 에러", message: "네트워크를 확인해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(action: UIAlertAction!) in
                print("exit()")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    // MARK: WKNavigationDelegate 중복적으로 리로드 방지 (iOS 9 이후지원)
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

// searchBar에서 검색하면 입력된 주소로 request
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.defaultRequest(searchBar.text!)
        
        // 다른곳을 터치하면 키보드 내리기
        self.view.endEditing(true)
    }
}

// https://developer.apple.com/documentation/webkit/wknavigationdelegate
// https://ios-development.tistory.com/27
// MARK: WKNavigationDelegate
extension WebViewController: WKNavigationDelegate{
    
    // 콘텐츠 로딩이 실패한 경우
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    // 윕뷰 로드가 완료되면 호출
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.searchBar.text = webView.url?.absoluteString // 현재 웹페이지의 URL을 searchBar에 띄어줌
    }
    // 웹뷰가 콘텐츠를 로드하기 시작할때 호출되는 메서드(url이 유효하지 않는 경우에도 호출)
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 웹뷰가 HTML 페이지의 콘텐츠를 읽어 들이기 시작할 때 호출 didStartProvisionalNavigation 호출후 바로 호출)
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    // 해당 url로 이동할지 말지를 결정
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)    // 이동취소
            return
        }
        
        let urlString = url.absoluteString
        if urlString.contains("특정url"){
            decisionHandler(.cancel)    // 이동취소
            return
        }else if urlString.contains("특정url") {
            // other process
            decisionHandler(.allow) // url 이동
        }
        
    }
    
    // url에 대한 응답값을 받은 뒤 이동할지를 결정한다.
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let _ = navigationResponse.response.url?.absoluteString else {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    // webview alert 띄우기
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
}
