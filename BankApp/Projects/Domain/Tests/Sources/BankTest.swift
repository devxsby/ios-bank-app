//
//  BankTest.swift
//  Domain
//
//  Created by devxsby on 2023/05/31.
//  Copyright © 2023 BankApp. All rights reserved.
//

import XCTest
@testable import Domain

class BankTests: XCTestCase {
    
    var sut: Bank!
    
    override func setUp() {
        super.setUp()
        
        let depositBankers: [Banker] = [
            Banker(type: .deposit, taskDuration: 5.0),
            Banker(type: .deposit, taskDuration: 5.0)
        ]
        
        let loanBankers: [Banker] = [
            Banker(type: .loan, taskDuration: 8.0)
        ]
        
        let depositCustomers: [Customer] = [
            Customer(number: 1, taskType: .deposit),
            Customer(number: 2, taskType: .deposit),
            Customer(number: 3, taskType: .deposit)
        ]
        
        let loanCustomers: [Customer] = [
            Customer(number: 1, taskType: .loan),
            Customer(number: 2, taskType: .loan),
            Customer(number: 3, taskType: .loan)
        ]
        
        sut = Bank(depositBankers: depositBankers, loanBankers: loanBankers, depositCustomers: depositCustomers, loanCustomers: loanCustomers)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_startProcessing_DepositCustomers() {
        // given
        var remainingCustomers: Int?
        var estimatedWaitTime: Double?
        let expectation = XCTestExpectation(description: "Processing completed")
        
        sut.printRemainingCustomers = { serviceType, remaining, waitTime in
            if serviceType == .deposit {
                remainingCustomers = remaining
                estimatedWaitTime = waitTime
                expectation.fulfill()
            }
        }
        
        // when
        sut.startProcessing() { }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(remainingCustomers, nil) // 0인지 nild인지 모르겠음
        XCTAssertEqual(estimatedWaitTime, nil) // 0.0인지 nild인지 모르겠음
    }
    
    func test_addCustomerToDepositQueue() {
        // given
        let initialCount = sut.depositCustomers.count
        let expectation = XCTestExpectation(description: "Added customer to deposit queue")
        var remainingCustomers: Int?
        var estimatedWaitTime: Double?
        
        sut.printRemainingCustomers = { serviceType, remaining, waitTime in
            if serviceType == .deposit {
                remainingCustomers = remaining
                estimatedWaitTime = waitTime
                expectation.fulfill()
            }
        }
        
        // when
        sut.addCustomerToDepositQueue()
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(remainingCustomers, initialCount + 1)
        XCTAssertEqual(estimatedWaitTime, Double(initialCount) * sut.depositBankers[0].taskDuration)
    }
    
    func test_removeLastCustomer_Deposit() {
        // given
        let initialCount = sut.depositCustomers.count
        
        // when
        sut.removeLastCustomer(.deposit)
        
        // then
        XCTAssertEqual(sut.depositCustomers.count, initialCount - 1)
    }
    
    func test_startProcessing_LoanCustomers() {
        // given
        var remainingCustomers: Int?
        var estimatedWaitTime: Double?
        let expectation = XCTestExpectation(description: "Added customer to loan queue")
        
        sut.printRemainingCustomers = { serviceType, remaining, waitTime in
            if serviceType == .loan {
                remainingCustomers = remaining
                estimatedWaitTime = waitTime
                expectation.fulfill()
            }
        }
        
        // when
        sut.startProcessing() { }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        
        // then
        XCTAssertEqual(remainingCustomers, nil) // 0인지 nild인지 모르겠음
        XCTAssertEqual(estimatedWaitTime, nil) // 0.0인지 nild인지 모르겠음
    }
    
    func test_addCustomerToLoanQueue() {
        // given
        let initialCount = sut.loanCustomers.count
        let expectation = XCTestExpectation(description: "Added customer to loan queue")
        var remainingCustomers: Int?
        var estimatedWaitTime: Double?
        
        sut.printRemainingCustomers = { serviceType, remaining, waitTime in
            if serviceType == .loan {
                remainingCustomers = remaining
                estimatedWaitTime = waitTime
                expectation.fulfill()
            }
        }
        
        // when
        sut.addCustomerToLoanQueue()
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(remainingCustomers, initialCount + 1)
        XCTAssertEqual(estimatedWaitTime, Double(initialCount + 1) * sut.loanBankers[0].taskDuration)
    }
    
    func test_removeLastCustomer_Loan() {
        // given
        let initialCount = sut.loanCustomers.count
        
        // when
        sut.removeLastCustomer(.loan)
        
        // then
        XCTAssertEqual(sut.loanCustomers.count, initialCount - 1)
    }
}
