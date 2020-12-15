//
//  LaunchSplashView.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2020/12/15.
//  Copyright © 2020 lunightlab. All rights reserved.
//

import UIKit
import Lottie

class LaunchSplashView: UIViewController {
    
    private var animationView: AnimationView?
    @IBOutlet var labViewDescript: UILabel!
    
    override func viewDidLoad() {
        TRACE_LOG()
        
        super.viewDidLoad()
        
        labViewDescript.textColor = Asset.defaultFont.color
        animationView = .init(name: "lottie-developer")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.animationSpeed = 1.0
        view.addSubview(animationView!)

        animationView!.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                                self.nextViewHandler()
                            } else {
                              print("Animation cancelled")
                            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TRACE_LOG()
    }
    
    func nextViewHandler() {
        TRACE_LOG()
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        firstVC.modalPresentationStyle = .fullScreen
        present(firstVC, animated: true, completion:  nil)
    }
    
}
