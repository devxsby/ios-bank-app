//
//  HomeUseCase.swift
//  Domain
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public protocol HomeUseCase {

}

public class DefaultHomeUseCase {
  
    private let repository: HomeRepositoryInterface
    private var cancelBag = CancelBag()
  
    public init(repository: HomeRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultHomeUseCase: HomeUseCase {
  
}
