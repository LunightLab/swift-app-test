//
//  ContainerViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/17.
//  Copyright © 2021 lunightlab. All rights reserved.
//
// url : https://medium.com/@jang.wangsu/swift-containerview-%EC%97%90-%EB%8C%80%ED%95%98%EC%97%AC-ee2ed07ec4e8
//       https://minominodomino.github.io/devlog/2019/05/19/ios-ContainerViewController/
//       https://velog.io/@cooo002/iosContainerView-Programmatically

import Foundation
import UIKit

class ContainerViewController: UIViewController {
    
    
    @IBOutlet weak var bottomContainerView: UIView!
    
    // MARK: -
    // MARK: View LiftCycle functions
    override func viewDidLoad() {

        super.viewDidLoad()
        
        guard let bottomView = storyboard?.instantiateViewController(withIdentifier: "BottomViewController") else {
            return
        }
        addChild(bottomView)
        bottomView.view.frame = bottomContainerView.bounds
        bottomContainerView.addSubview(bottomView.view)

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
    
    @IBAction func btnChildRemoveAll(_ sender: Any) {
        for vc in children {
            vc.view.removeFromSuperview()   // 제약사항제거
            vc.removeFromParent()
        }
    }
    
    // View Add 추가
//    @IBAction func btnAddChildController(_ sender: Any) {
//        
//        let storyboard = UIStoryboard(name: <#T##String#>, bundle: nil)
//        let addViewController = storyboard.instantiateViewController(withIdentifier: "")
//        addViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.addChild(addViewController)
//        self.view.addSubview(addViewController.view)
//        addViewController.didMove(toParent: self)
//    }

}
