//
//  ServiceUseCase.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core
import Network

public protocol ServiceUseCase {
    func processDeposit(completion: @escaping (Int, Double) -> Void)
    func processLoan(completion: @escaping (Int, Double) -> Void)
}

public class DefaultServiceUseCase {
    public let repository: ServiceRepositoryInterface
    public let customerGenerator: CustomerGenerator

    public init(repository: ServiceRepositoryInterface, customerGenerator: CustomerGenerator) {
        self.repository = repository
        self.customerGenerator = customerGenerator
    }
}

// MARK: - Methods

extension DefaultServiceUseCase: ServiceUseCase {
    public func processDeposit(completion: @escaping (Int, Double) -> Void) {
        let depositBankers = [Banker(type: .deposit, taskDuration: 3.0)]
        let depositCustomers = (1...16).map { Customer(number: $0, taskType: .deposit) }

        let bank = Bank(depositBankers: depositBankers, loanBankers: [], depositCustomers: depositCustomers, loanCustomers: [])

        bank.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            if taskType == .deposit {
                completion(remainingCustomers, estimatedWaitTime)
                WaitingInfoManager.shared.depositCount = remainingCustomers
                WaitingInfoManager.shared.depositTime = estimatedWaitTime
            }
        }

        bank.startProcessing()
    }

    public func processLoan(completion: @escaping (Int, Double) -> Void) {
        let loanBankers = [Banker(type: .loan, taskDuration: 5.0)]
        let loanCustomers = (1...9).map { Customer(number: $0, taskType: .loan) }

        let bank = Bank(depositBankers: [], loanBankers: loanBankers, depositCustomers: [], loanCustomers: loanCustomers)

        bank.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            if taskType == .loan {
                completion(remainingCustomers, estimatedWaitTime)
                WaitingInfoManager.shared.loanCount = remainingCustomers
                WaitingInfoManager.shared.loanTime = estimatedWaitTime
            }
        }

        bank.startProcessing()
    }
}
