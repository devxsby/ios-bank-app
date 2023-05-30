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
    
    // MARK: - Properties
    
    private var isLoading: Bool = true
    
    public let depositQueue = DispatchQueue(label: "DepositQueue", attributes: .concurrent)
    public let loanQueue = DispatchQueue(label: "LoanQueue", qos: .userInitiated)
    
    private let depositSemaphore = DispatchSemaphore(value: 2)
    
    public let depositBankers: [Banker]
    public let loanBankers: [Banker]
    public var depositCustomers: [Customer]
    public var loanCustomers: [Customer]
    
    public var printRemainingCustomers: ((BankingServiceType, Int?, Double?) -> Void)?
    
    // MARK: - Initialization
    
    public init(depositBankers: [Banker], loanBankers: [Banker], depositCustomers: [Customer], loanCustomers: [Customer]) {
        self.depositBankers = depositBankers
        self.loanBankers = loanBankers
        self.depositCustomers = depositCustomers
        self.loanCustomers = loanCustomers
    }
    
    public func startProcessing() {
        setInitialValue()
        processDepositCustomers()
        processLoanCustomers()
    }
}

// MARK: - Methods

extension Bank {
    
    private func setInitialValue() {
        printRemainingCustomers?(.deposit, nil, nil)
        printRemainingCustomers?(.loan, nil, nil)
    }
    
    private func processDepositCustomers() {
        let group = DispatchGroup()
        
        depositQueue.async(group: group) {
            while !self.depositCustomers.isEmpty {
                if let banker = self.depositBankers.first {
                    group.enter()
                    
                    self.depositSemaphore.wait()
                    
                    Thread.sleep(forTimeInterval: banker.taskDuration)
                    
                    self.depositCustomers.removeFirst()
                    
                    let remainingCustomers = self.depositCustomers.count
                    let estimatedDepositWaitTime = Double(remainingCustomers) * banker.taskDuration
                    
                    self.printRemainingCustomers?(.deposit, remainingCustomers, estimatedDepositWaitTime)
                    
                    self.depositSemaphore.signal()
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.isLoading = false
            self.printRemainingCustomers?(.deposit, self.depositCustomers.count, 0.0)
        }
    }
    
    private func processLoanCustomers() {
        let totalLoanCustomers = loanCustomers.count
        
        loanQueue.async {
            while !self.loanCustomers.isEmpty {
                if let banker = self.loanBankers.first {
                    let remainingCustomers = self.loanCustomers.count - 1
                    let estimatedTimeRemaining = Double(remainingCustomers) * banker.taskDuration
                    
                    Thread.sleep(forTimeInterval: banker.taskDuration)
                    self.loanCustomers.removeFirst()
                    self.printRemainingCustomers?(.loan, remainingCustomers, estimatedTimeRemaining)
                }
            }
        }
    }
    
    public func addCustomerToDepositQueue() {
        depositQueue.async {
            self.depositSemaphore.wait()
            
            if self.depositCustomers.isEmpty == true {
                return
            }
            
            if let firstBanker = self.depositBankers.first {
                self.depositCustomers.append(Customer(number: self.depositCustomers.count + 1, taskType: .deposit))
                let remainingCustomers = self.depositCustomers.count
                let estimatedDepositWaitTime = Double(remainingCustomers) * firstBanker.taskDuration
                
                if self.isLoading {
                    DispatchQueue.main.async {
                        self.printRemainingCustomers?(.deposit, remainingCustomers, estimatedDepositWaitTime)
                    }
                } else {
                    self.printRemainingCustomers?(.deposit, remainingCustomers, estimatedDepositWaitTime)
                }
            }
            
            self.depositSemaphore.signal()
        }
    }
    
    public func addCustomerToLoanQueue() {
        loanQueue.async {
            self.depositSemaphore.wait()
            
            if self.loanCustomers.isEmpty == true {
                return
            }
            
            if let firstBanker = self.loanBankers.first {
                self.loanCustomers.append(Customer(number: self.loanCustomers.count + 1, taskType: .loan))
                let remainingCustomers = self.loanCustomers.count
                let estimatedLoanWaitTime = Double(remainingCustomers) * firstBanker.taskDuration
                
                if self.isLoading {
                    DispatchQueue.main.async {
                        self.printRemainingCustomers?(.loan, remainingCustomers, estimatedLoanWaitTime)
                    }
                } else {
                    self.printRemainingCustomers?(.loan, remainingCustomers, estimatedLoanWaitTime)
                }
            }
            
            self.depositSemaphore.signal()
        }
    }
}

