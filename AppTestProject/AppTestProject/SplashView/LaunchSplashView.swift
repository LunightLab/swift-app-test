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
        animationView!.animationSpeed = 2.0
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
        self.showToast(message: "test toast message")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TRACE_LOG()
    }
    
    func nextViewHandler() {
        TRACE_LOG()
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        firstVC.modalPresentationStyle = .fullScreen
        present(firstVC, animated: true, completion:  nil)
    }
    
     
    /// Custom Toast Message
    /// - Parameters:
    ///   - message: message string
    ///   - font: uifont style
    func showToast(message: String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = Asset.toastBG.color
        toastLabel.textColor = Asset.toastText.color
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
