//
//  Bank.swift
//  Network
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public class Bank {
    
    public let depositQueue = DispatchQueue(label: "DepositQueue", attributes: .concurrent)
    public let loanQueue = DispatchQueue(label: "LoanQueue", qos: .userInitiated) // qos 뭐로 할지?
    
    private let depositSemaphore = DispatchSemaphore(value: 2)
    
    public let depositBankers: [Banker]
    public let loanBankers: [Banker]
    public var depositCustomers: [Customer]
    public var loanCustomers: [Customer]
    
    public var printRemainingCustomers: ((BankingServiceType, Int, Double) -> Void)?
    
    public init(depositBankers: [Banker], loanBankers: [Banker], depositCustomers: [Customer], loanCustomers: [Customer]) {
        self.depositBankers = depositBankers
        self.loanBankers = loanBankers
        self.depositCustomers = depositCustomers
        self.loanCustomers = loanCustomers
    }
    
    public func startProcessing() {
        processDepositCustomers()
        processLoanCustomers()
    }
}

extension Bank {
    
//    private func processDepositCustomers() {
//        let group = DispatchGroup()
//        let totalDepositCustomers = depositCustomers.count
//        print("예금 총 고객수: \(totalDepositCustomers)")
//
//        depositQueue.async {
//            var remainingCustomers = totalDepositCustomers
//            var estimatedWaitTime = Double(totalDepositCustomers) * (self.depositBankers.first?.taskDuration ?? 0.0)
//
//            for (index, depositCustomer) in self.depositCustomers.enumerated() {
//                group.enter()
//
//                if let banker = self.depositBankers.first {
//                    DispatchQueue.global().async {
//                        Thread.sleep(forTimeInterval: banker.taskDuration)
//
//                        DispatchQueue.main.async {
//                            remainingCustomers -= 1
//                            estimatedWaitTime = Double(remainingCustomers) * (self.depositBankers.first?.taskDuration ?? 0.0)
//
//                            self.printRemainingCustomers?(.deposit, remainingCustomers, estimatedWaitTime)
//                            group.leave()
//                        }
//
//                    }
//                }
//            }
//
//            group.wait()
//        }
//    }

    private func processDepositCustomers() {
        let group = DispatchGroup()
        let totalDepositCustomers = depositCustomers.count
        print("예금 총 고객수: \(totalDepositCustomers)")
        
        depositQueue.async {
            var remainingCustomers = totalDepositCustomers
            var estimatedWaitTime = Double(totalDepositCustomers) * (self.depositBankers.first?.taskDuration ?? 0.0)
            
            for (index, depositCustomer) in self.depositCustomers.enumerated() {
                
                group.enter()
                
                if let banker = self.depositBankers.first {
                    Thread.sleep(forTimeInterval: banker.taskDuration)
                    
                    let remainingCustomers = totalDepositCustomers - index - 1
                    let estimatedWaitTime = Double(remainingCustomers) * banker.taskDuration
                    
                    DispatchQueue.global().async {
                        
                        self.printRemainingCustomers?(.deposit, remainingCustomers, estimatedWaitTime)
                        group.leave()
                    }
                }
            }
            group.wait()
        }
    }
    
    private func processLoanCustomers() {
        let totalLoanCustomers = loanCustomers.count
        print("대출 총 고객수: \(totalLoanCustomers)")

        loanQueue.async {
            for (index, loanCustomer) in self.loanCustomers.enumerated() {
                if let banker = self.loanBankers.first {
                    let remainingCustomers = totalLoanCustomers - index - 1
                    let estimatedTimeRemaining = Double(remainingCustomers) * banker.taskDuration

                    Thread.sleep(forTimeInterval: banker.taskDuration)
                    self.printRemainingCustomers?(.loan, remainingCustomers, estimatedTimeRemaining)
                }
            }
        }
    }
}
