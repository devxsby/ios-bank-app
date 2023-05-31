//
//  CustomerGenerator.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public final class CustomerGenerator {
    
    public init() { }
    
    public func generateRandomCustomers() -> (depositCustomers: [Customer], loanCustomers: [Customer]) {
        var depositCustomers = [Customer]()
        var loanCustomers = [Customer]()
        
        var depositNumber = 1
        var loanNumber = 1
        
        for _ in 1...20 {
            let randomType: BankingServiceType = Bool.random() ? .deposit : .loan
            
            if randomType == .deposit {
                let customer = Customer(number: depositNumber, taskType: randomType)
                depositCustomers.append(customer)
                depositNumber += 1
            } else {
                let customer = Customer(number: loanNumber, taskType: randomType)
                loanCustomers.append(customer)
                loanNumber += 1
            }
        }
        return (depositCustomers, loanCustomers)
    }
}
