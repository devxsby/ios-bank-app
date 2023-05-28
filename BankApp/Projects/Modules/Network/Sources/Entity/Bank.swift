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
    
    private func processDepositCustomers() {
        let group = DispatchGroup()
        let totalDepositCustomers = depositCustomers.count
//        print("예금 총 고객수: \(totalDepositCustomers)")
        
        depositQueue.async {
            var remainingCustomers = totalDepositCustomers
            var estimatedWaitTime = Double(totalDepositCustomers) * (self.depositBankers.first?.taskDuration ?? 0.0)
            
            for (index, _) in self.depositCustomers.enumerated() {
                group.enter()
                
                let bankerIndex = index % self.depositBankers.count // 뱅커 인덱스 계산
                
                let banker = self.depositBankers[bankerIndex]
                self.depositSemaphore.wait() // 세마포어 대기
                
                Thread.sleep(forTimeInterval: banker.taskDuration)
                
                remainingCustomers -= 1
                estimatedWaitTime = Double(remainingCustomers) * banker.taskDuration
                
                DispatchQueue.global().async {
                    self.printRemainingCustomers?(.deposit, remainingCustomers, estimatedWaitTime)
                    self.depositSemaphore.signal() // 세마포어 신호
                    group.leave()
                }
            }
            
            group.wait()
        }
    }
    
    private func processLoanCustomers() {
        let totalLoanCustomers = loanCustomers.count
//        print("대출 총 고객수: \(totalLoanCustomers)")

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
