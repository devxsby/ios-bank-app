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

public class ServiceViewModel {
    
    // MARK: - Properties
    
    private let usecase: ServiceUseCase
    
    private var lastDepositRemainingCustomers: Int = 0
    private var lastLoanRemainingCustomers: Int = 0
    
    public var depositCountDidChange: ((Int, Double) -> Void)?
    public var loanCountDidChange: ((Int, Double) -> Void)?
    
    // MARK: - Initialization
    
    public init(usecase: ServiceUseCase) {
        self.usecase = usecase
    }
    
    // MARK: - Methods
    
    public func startProcessing() {
        self.startProcessingDeposit()
        self.startProcessingLoan()
    }
    
    public func addCustomer(type: BankingServiceType) {
        usecase.addCustomer(type: type) { [weak self] remainingCustomers, estimatedWaitTime in
            switch type {
            case .deposit:
                self?.depositCountDidChange?(remainingCustomers, estimatedWaitTime)
            case .loan:
                self?.loanCountDidChange?(remainingCustomers, estimatedWaitTime)
            }
        }
    }

//    public func removeCustomer(type: BankingServiceType) {
//        usecase.removeCustomer(type: type) { [weak self] remainingCustomers, estimatedWaitTime in
//            switch type {
//            case .deposit:
//                self?.depositCountDidChange?(remainingCustomers, estimatedWaitTime)
//            case .loan:
//                self?.loanCountDidChange?(remainingCustomers, estimatedWaitTime)
//            }
//        }
//    }
}

extension ServiceViewModel {
    
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
