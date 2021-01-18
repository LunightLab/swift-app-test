//
//  RxSimpleViewController.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/18.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import UIKit
import RxSwift

class RxSimpleViewController : UIViewController {
    
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
    
    // MARK: -
    @IBAction func btnBack(_ sender: Any) {
        print("back")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
