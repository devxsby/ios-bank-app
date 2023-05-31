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
            Banker(type: .deposit, taskDuration: 1.0),
            Banker(type: .loan, taskDuration: 2.0),
            Banker(type: .loan, taskDuration: 3.0)
        ]
        
        let depositCustomers: [Customer] = [
            Customer(number: 1, taskType: .deposit),
            Customer(number: 2, taskType: .deposit),
            Customer(number: 3, taskType: .deposit)
        ]
        
        sut = Bank(depositBankers: depositBankers, loanBankers: [], depositCustomers: depositCustomers, loanCustomers: [])
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_처음시작시_대출창구가_제대로동작하는지() {
        // given
        var remainingCustomers: Int?
        var estimatedWaitTime: Double?
        
        sut.printRemainingCustomers = { serviceType, remaining, waitTime in
            if serviceType == .deposit {
                remainingCustomers = remaining
                estimatedWaitTime = waitTime
            }
        }
        
        // when
        sut.startProcessing()
        
        let expectation = XCTestExpectation(description: "Processing completed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertEqual(remainingCustomers, 0)
        XCTAssertEqual(estimatedWaitTime, 0.0)
    }
    
    func test_예금창구에_고객한명을추가했을때_대기시간이_1번의taskduration만큼_늘었는지() {
        // given
        let initialCount = sut.depositCustomers.count
        let expectation = XCTestExpectation(description: "예금창구에 고객을 추가함.")
        var remainingCustomers: Int?
        var estimatedWaitTime: Double?

        sut.printRemainingCustomers = { serviceType, remaining, waitTime in
            if serviceType == .deposit {
                remainingCustomers = remaining
                estimatedWaitTime = waitTime
                expectation.fulfill() // 클로저 실행 후 expectation 완료
            }
        }

        // when
        sut.addCustomerToDepositQueue()

        // then
        wait(for: [expectation], timeout: 5.0) // expectation이 완료될 때까지 대기
        XCTAssertEqual(remainingCustomers, initialCount + 1)
        XCTAssertEqual(estimatedWaitTime, Double(initialCount) * sut.depositBankers[0].taskDuration)
    }
    
    func test_예금창구에_마지막고객삭제후_고객숫자가_하나_감소했는지() {
        // given
        let initialCount = sut.depositCustomers.count
        
        // when
        sut.removeLastCustomer(.deposit)
        
        // then
        XCTAssertEqual(sut.depositCustomers.count, initialCount - 1)
    }
}
