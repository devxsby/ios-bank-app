//
//  ServiceRepositoryInterface.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

import Network

public protocol ServiceRepositoryInterface {
    func saveBank(_ bank: Bank)
}
