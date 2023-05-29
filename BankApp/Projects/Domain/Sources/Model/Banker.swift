//
//  Banker.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public struct Banker {
    public let type: BankingServiceType
    public let taskDuration: Double
    
    public init(type: BankingServiceType, taskDuration: Double) {
        self.type = type
        self.taskDuration = taskDuration
    }
}
