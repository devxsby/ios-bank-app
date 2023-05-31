//
//  CustomerGeneratorTest.swift
//  Domain
//
//  Created by devxsby on 2023/05/31.
//  Copyright © 2023 BankApp. All rights reserved.
//

import XCTest
@testable import Domain

class CustomerGeneratorTest: XCTestCase {
    
    func test_20개의_랜덤고객배열이_생성되는지() {
        let generator = CustomerGenerator()
        
        let customers = generator.generateRandomCustomers()
        
        XCTAssertNotNil(customers)
        XCTAssertEqual(customers.depositCustomers.count + customers.loanCustomers.count, 20)
    }
}
