//
//  ServiceViewModel.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Combine

import Core
import Domain

public class ServiceViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private let usecase: ServiceUseCase
    private var cancelBag = CancelBag()
    
    public var depositCountDidChange: ((Int, Double) -> Void)?
    public var loanCountDidChange: ((Int, Double) -> Void)?
  
    // MARK: - Inputs
    
    public struct Input {
        public init() {

        }
    }
    
    // MARK: - Outputs
    
    public struct Output {
    
    }

    
    // MARK: - Initialization
    
    public init(usecase: ServiceUseCase) {
        self.usecase = usecase
    }
    
    public func startProcessing() {
        
        usecase.processBank { [weak self] (count, time) in
            self?.depositCountDidChange?(count, time)
            self?.loanCountDidChange?(count, time)
        }
    }
}

extension ServiceViewModel {
    
    public func transform(from input: Input, cancelBag: Core.CancelBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        // input,output 상관관계 작성
    
        return output
    }
    
    private func bindOutput(output: Output, cancelBag: Core.CancelBag) {
    
    }
}
