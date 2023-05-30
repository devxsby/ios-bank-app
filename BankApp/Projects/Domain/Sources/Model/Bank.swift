//
//  Bank.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

// TODO: - 🚨 생각해보니까 내 뒤에 또 다른 고객이 대기 할 수가 있음

public class Bank {
    
    public let depositQueue = DispatchQueue(label: "DepositQueue", attributes: .concurrent)
    public let loanQueue = DispatchQueue(label: "LoanQueue", qos: .userInitiated)
    
    private let depositSemaphore = DispatchSemaphore(value: 2)
    
    private var remainingDepositCustomers: Int = 0
    private var estimatedDepositWaitTime: Double = 0.0
    
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
    
    public func addCustomerToDepositQueue() {
        depositQueue.async {
            self.depositSemaphore.wait()
            
            if let firstBanker = self.depositBankers.first {
                self.remainingDepositCustomers += 1
                self.estimatedDepositWaitTime = Double(self.remainingDepositCustomers) * firstBanker.taskDuration
                self.printRemainingCustomers?(.deposit, self.remainingDepositCustomers, self.estimatedDepositWaitTime)
            }
            
            self.depositSemaphore.signal()
        }
    }
    
    public func addCustomerToLoanQueue() {
        // 아직 x
    }
    
    
    private func processDepositCustomers() {
        let group = DispatchGroup()
        
        // TODO: index 0이면 끝나서 업데이트가 안됨. while 문으로 바꾸기
        depositQueue.async {
            for index in stride(from: self.depositCustomers.count, through: 0, by: -1) {
                if let banker = self.depositBankers.first {
                    group.enter()
                    
                    self.depositSemaphore.wait()
                    
                    Thread.sleep(forTimeInterval: banker.taskDuration)
                    
                    self.remainingDepositCustomers = index
                    self.estimatedDepositWaitTime = Double(self.remainingDepositCustomers) * banker.taskDuration
                    
                    self.printRemainingCustomers?(.deposit, self.remainingDepositCustomers, self.estimatedDepositWaitTime)
                    
                    self.depositSemaphore.signal()
                    group.leave()
                }
            }
            
            group.wait()
        }
    }
    
    private func processLoanCustomers() {
        let totalLoanCustomers = loanCustomers.count
        
        loanQueue.async {
            for (index, _) in self.loanCustomers.enumerated() {
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

