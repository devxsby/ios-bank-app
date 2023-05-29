//
//  Customer.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public struct Customer {
    public let number: Int
    public let taskType: BankingServiceType
    
    public init(number: Int, taskType: BankingServiceType) {
        self.number = number
        self.taskType = taskType
    }
}
