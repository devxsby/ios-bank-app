//
//  HomeRepository.swift
//  Data
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

import Core
import Domain
import Network

public class HomeRepository {
    
    private let cancelBag = Core.CancelBag()
    
    public init() {
        
    }
}

extension HomeRepository: HomeRepositoryInterface {
    
}
