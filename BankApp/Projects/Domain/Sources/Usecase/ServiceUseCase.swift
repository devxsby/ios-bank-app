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
    func processDeposit(completion: @escaping (Int, Double) -> Void)
    func processLoan(completion: @escaping (Int, Double) -> Void)
    func addCustomer(type: BankingServiceType, completion: @escaping (Int, Double) -> Void)
//    func removeCustomer(type: BankingServiceType, completion: @escaping (Int, Double) -> Void)
}

public class DefaultServiceUseCase {
    
    public let repository: ServiceRepositoryInterface
    public let customerGenerator: CustomerGenerator
    
    private let depositBankers = [Banker(type: .deposit, taskDuration: 3.0)]
    private let loanBankers = [Banker(type: .loan, taskDuration: 5.0)]
    private var depositBank = Bank(depositBankers: [], loanBankers: [], depositCustomers: [], loanCustomers: [])
    private var loanBank = Bank(depositBankers: [], loanBankers: [], depositCustomers: [], loanCustomers: [])
    
    private let depositCustomers = (1...5).map { Customer(number: $0, taskType: .deposit) }
    private let loanCustomers = (1...4).map { Customer(number: $0, taskType: .loan) }

    
    public init(repository: ServiceRepositoryInterface, customerGenerator: CustomerGenerator) {
        self.repository = repository
        self.customerGenerator = customerGenerator
    }
}

// MARK: - Methods

extension DefaultServiceUseCase: ServiceUseCase {
    
    public func processDeposit(completion: @escaping (Int, Double) -> Void) {

        depositBank = Bank(depositBankers: depositBankers, loanBankers: [],
                           depositCustomers: depositCustomers, loanCustomers: [])
        
        depositBank.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            if taskType == .deposit {
                completion(remainingCustomers, estimatedWaitTime)
                WaitingInfoManager.shared.depositCount = remainingCustomers
                WaitingInfoManager.shared.depositTime = estimatedWaitTime
            }
        }
        depositBank.startProcessing()
    }
    
    public func processLoan(completion: @escaping (Int, Double) -> Void) {
        
        loanBank = Bank(depositBankers: [], loanBankers: loanBankers,
                        depositCustomers: [], loanCustomers: loanCustomers)
        
        loanBank.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            if taskType == .loan {
                completion(remainingCustomers, estimatedWaitTime)
                WaitingInfoManager.shared.loanCount = remainingCustomers
                WaitingInfoManager.shared.loanTime = estimatedWaitTime
            }
        }
        loanBank.startProcessing()
    }
    
    public func addCustomer(type: BankingServiceType, completion: @escaping (Int, Double) -> Void) {
        switch type {
        case .deposit:
            let newCustomer = Customer(number: depositCustomers.count + 1, taskType: type)
            return depositBank.addCustomerToDepositQueue()
        case .loan:
            let newCustomer = Customer(number: loanCustomers.count + 1, taskType: type)
            return loanBank.addCustomerToLoanQueue()
        }
    }
    
//    public func removeCustomer(type: BankingServiceType, completion: @escaping (Int, Double) -> Void) {
//        switch type {
//        case .deposit:
//            return depositBank.dequeueDepositCustomer()
//        case .loan:
//            return loanBank.dequeueLoanCustomer()
//        }
//    }
}
