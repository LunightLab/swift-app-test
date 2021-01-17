//
//  TestListViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/28.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit
import Alamofire

// FIXME: MVVM 적용 필요
class TestListViewController: UIViewController {
    
    @IBOutlet var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testTableView.dataSource = self
        self.testTableView.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

extension TestListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // tableview section count
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Hard test..💬"
        case 1:
            return "Simple test..💬"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return hardTestList.count
        default:
            return normalTestList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath)
        let text: String = indexPath.section == 0 ? hardTestList[indexPath.row] : normalTestList[indexPath.row]
        cell.textLabel?.text = text
//        cell.textLabel?.text = TableList.getTestList(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: // MARK: 👨🏻‍💻wkwebview - script
                ToastMessage.Message(str: "작업중", duration: 2.0)
            case 1: // MARK: 👨🏻‍💻mvvm-simple
                guard let webvc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleMvvmVC") else {
                    return
                }
                webvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                webvc.modalPresentationStyle = .fullScreen
                self.present(webvc, animated: true)
            case 2: // MARK: 👨🏻‍💻mvvm(rxswift)
                ToastMessage.Message(str: "작업중", duration: 2.0)
            case 3: // MARK: 👨🏻‍💻Network
                guard let webvc = self.storyboard?.instantiateViewController(withIdentifier: "NetworkVC") else {
                    return
                }
            default:
                ToastMessage.Message(str: "연결필요", duration: 2.0)
            }
        }else if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                // MARK: 👨🏻‍💻wkwebview - basic
                if Reachability.isConnectedToNetwork() {
                    guard let webvc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") else {
                        return
                    }
                    webvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                    webvc.modalPresentationStyle = .fullScreen
                    self.present(webvc, animated: true)
                }else{
                    let alert = UIAlertController(title: "네트워크 에러", message: "네트워크를 확인해주세요", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(action: UIAlertAction!) in
                        print("exit()")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            case 1:
                ToastMessage.Message(str: "작업중", duration: 2.0)
            case 3:
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") else {
                    return
                }
                vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            default:
                ToastMessage.Message(str: "연결필요", duration: 2.0)
            }
        } else { ToastMessage.Message(str: "연결섹션이 없음.", duration: 2.0) }

        
    }
}

class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
