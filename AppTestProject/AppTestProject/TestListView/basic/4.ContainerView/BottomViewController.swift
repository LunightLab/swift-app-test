//
//  BottomContainerViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/17.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import UIKit

class BottomViewController: UIViewController {
    

    // MARK: -
    // MARK: View LiftCycle functions
    override func viewDidLoad() {

        super.viewDidLoad()

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

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print("Will Move in BottomView")
    }
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print("did Move in BottomView")
    }
    
    @IBAction func btnRemoveBottonView(_ sender: Any) {
        view.removeFromSuperview()
        removeFromParent()
    }
    

    
}
