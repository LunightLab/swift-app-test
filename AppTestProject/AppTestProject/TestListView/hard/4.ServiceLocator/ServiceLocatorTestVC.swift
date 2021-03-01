//
//  ViewController.swift
//  ServiceLocatorTest
//
//  Created by Kyung Shik Kim on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Service Locateor initialization

        let sl: ServiceLocator = {
            let sl = NaiveServiceLocator.shred
            sl.s1 = S1Impl()
            sl.s2 = S2Impl()
            return sl
        }()


        
        print(sl.s1?.f1() ?? "not found")
        print(sl.s2?.f2() ?? "not found")
        
    }


}


