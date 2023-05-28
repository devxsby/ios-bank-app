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
        self.startProcessingDeposit()
        self.startProcessingLoan()
    }
    
    private func startProcessingDeposit() {
        usecase.processDeposit { [weak self] remainingCustomers, estimatedWaitTime in
            self?.depositCountDidChange?(remainingCustomers, estimatedWaitTime)
        }
    }
    
    private func startProcessingLoan() {
        usecase.processLoan { [weak self] remainingCustomers, estimatedWaitTime in
            self?.loanCountDidChange?(remainingCustomers, estimatedWaitTime)
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
