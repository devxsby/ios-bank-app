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
    func processBank(completion: @escaping (Int, Double) -> Void)
}

public class DefaultServiceUseCase {
  
    public let repository: ServiceRepositoryInterface
    public let customerGenerator: CustomerGenerator
    private var bank: Bank?
  
    public init(repository: ServiceRepositoryInterface, customerGenerator: CustomerGenerator) {
        self.repository = repository
        self.customerGenerator = customerGenerator
    }

    public func processBank(completion: @escaping (Int, Double) -> Void) {
        // Usage
        let depositBankers = [
            Banker(type: .deposit, taskDuration: 1.0),
            Banker(type: .deposit, taskDuration: 2.0)
        ]

        let loanBankers = [
            Banker(type: .loan, taskDuration: 1.0),
            Banker(type: .loan, taskDuration: 2.0),
            Banker(type: .loan, taskDuration: 1.5)
        ]

        let depositCustomers = (1...7).map { Customer(number: $0, taskType: .deposit) }
        let loanCustomers = (1...3).map { Customer(number: $0, taskType: .loan) }

        bank = Bank(depositBankers: depositBankers, loanBankers: loanBankers, depositCustomers: depositCustomers, loanCustomers: loanCustomers)
        
        bank?.printRemainingCustomers = { taskType, remainingCustomers, estimatedWaitTime in
            print("\(taskType) 대기 중 - 남은 고객수: \(remainingCustomers), 예상 대기 시간: \(estimatedWaitTime)초")
        }
        
        bank?.startProcessing()
    }
}

extension DefaultServiceUseCase: ServiceUseCase {
}
