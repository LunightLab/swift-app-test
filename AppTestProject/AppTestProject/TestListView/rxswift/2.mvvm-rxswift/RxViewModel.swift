//
//  RxViewModel.swift
//  AppTestProject
//
//  Created by Kyung Shik Kim on 2021/01/18.
//  Copyright © 2021 lunightlab. All rights reserved.
//

import Foundation
import RxRelay
import RxCocoa
import RxSwift

protocol viewModelType {
    var tap: PublishRelay<Void> { get }
    var number: Driver<String> { get }
}

class RxViewModel: viewModelType {
    
    // input
    let tap = PublishRelay<Void>()
    
    // output
    let number: Driver<String>
    
    private let model = BehaviorRelay<RxModel>(value: .init(number: 100))
    let disposeBag = DisposeBag()
    
    init() {
        self.number = self.model
            .map {"\($0.number)" }
            .asDriver(onErrorRecover: { _ in .empty() })
        
        self.tap
            .withLatestFrom(model)
            .map { model -> RxModel in
                var nextModel = model
                nextModel.number += 1
                return nextModel
            }.bind(to: self.model)
            .disposed(by: disposeBag)
    }
}
