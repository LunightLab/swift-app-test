//
//  RxVC.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/18.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import UIKit
import RxSwift

final class RxVC: UIViewController {
    
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var viewModel: viewModelType
    var disposeBag = DisposeBag()   // 해제
    
//    init(viewModel: ViewModelType) {
//       self.viewModel = viewModel
//     }
//
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: View LiftCycle
    override func viewDidLoad() {

        super.viewDidLoad()

        self.bind(viewModel: self.viewModel as! RxViewModel)
        
    }
    


    
    private func bind(viewModel: RxViewModel) {
        self.viewModel.number
          .drive(self.lab.rx.text)
          .disposed(by: self.disposeBag)
        
        self.button.rx.tap
          .bind(to: viewModel.tap)
          .disposed(by: self.disposeBag)
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
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
