//
//  HomeViewModel.swift
//  MainFeatureInterface
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Combine

import Core
import Domain

public class HomeViewModel: ViewModelType {
    
    private let useCase: HomeUseCase
    private var cancelBag = CancelBag()
  
    // MARK: - Inputs
    
    public struct Input {
        public init() {

        }
    }
    
    // MARK: - Outputs
    
    public struct Output {
    
    }

    
    // MARK: - Initialization
    
    public init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
}

extension HomeViewModel {
    
    public func transform(from input: Input, cancelBag: Core.CancelBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        // input,output 상관관계 작성
    
        return output
    }
    
    private func bindOutput(output: Output, cancelBag: Core.CancelBag) {
    
    }
}
