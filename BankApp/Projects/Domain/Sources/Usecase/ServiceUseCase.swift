//
//  ServiceUseCase.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public protocol ServiceUseCase {
    func processDeposit(completion: @escaping (Int?, Double?) -> Void)
    func processLoan(completion: @escaping (Int?, Double?) -> Void)
    func addCustomer(type: BankingServiceType, completion: @escaping (Int, Double) -> Void)
    func removeCustomer(type: BankingServiceType)
}

public class DefaultServiceUseCase {
    
    public let repository: ServiceRepositoryInterface
    public let customerGenerator: CustomerGenerator
    
    private let depositBankers = [Banker(type: .deposit, taskDuration: 5.0)]
    private let loanBankers = [Banker(type: .loan, taskDuration: 8.0)]
    private var depositCustomers = [Customer]()
    private var loanCustomers = [Customer]()
    private var depositBank: Bank?
    private var loanBank: Bank?
    
    public init(repository: ServiceRepositoryInterface, customerGenerator: CustomerGenerator) {
        self.repository = repository
        self.customerGenerator = customerGenerator
        generateRandomCustomers()
    }
    
    private func generateRandomCustomers() {
        let result = customerGenerator.generateRandomCustomers()
        depositCustomers = result.depositCustomers
        loanCustomers = result.loanCustomers
    }
}

// MARK: - Methods

extension DefaultServiceUseCase: ServiceUseCase {
    
    public func processDeposit(completion: @escaping (Int?, Double?) -> Void) {
        depositBank = Bank(depositBankers: depositBankers, loanBankers: [],
                           depositCustomers: depositCustomers, loanCustomers: [])
        
        depositBank?.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            if taskType == .deposit {
                completion(remainingCustomers, estimatedWaitTime)
                WaitingInfoManager.shared.depositCount = remainingCustomers ?? 0
                WaitingInfoManager.shared.depositTime = estimatedWaitTime ?? 0.0
            }
        }
        
        depositBank?.startProcessing {
            completion(0, 0.0)
        }
    }

    public func processLoan(completion: @escaping (Int?, Double?) -> Void) {
        loanBank = Bank(depositBankers: [], loanBankers: loanBankers,
                        depositCustomers: [], loanCustomers: loanCustomers)
        
        loanBank?.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            if taskType == .loan {
                completion(remainingCustomers, estimatedWaitTime)
                WaitingInfoManager.shared.loanCount = remainingCustomers ?? 0
                WaitingInfoManager.shared.loanTime = estimatedWaitTime ?? 0.0
            }
        }
        
        loanBank?.startProcessing {
            completion(0, 0.0)
        }
    }
    
    public func addCustomer(type: BankingServiceType, completion: @escaping (Int, Double) -> Void) {
        switch type {
        case .deposit:
            depositBank?.addCustomerToDepositQueue()
        case .loan:
            loanBank?.addCustomerToLoanQueue()
        }
    }
    
    public func removeCustomer(type: BankingServiceType) {
        switch type {
        case .deposit:
            depositBank?.removeLastCustomer(.deposit)
        case .loan:
            loanBank?.removeLastCustomer(.loan)
        }
    }
}
