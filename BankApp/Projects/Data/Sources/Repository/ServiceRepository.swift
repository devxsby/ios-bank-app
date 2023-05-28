//
//  ServiceRepository.swift
//  Data
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

import Core
import Domain
import Network

public class ServiceRepository {
    
    private let cancelBag = Core.CancelBag()
    private var bank: Bank?
    
    public init(bank: Bank? = nil) {
        self.bank = bank
    }
}

extension ServiceRepository: ServiceRepositoryInterface {
    
    public func saveBank(_ bank: Bank) {
        self.bank = bank
    }
    
    public func getBank() -> Bank? {
        return bank
    }
}
