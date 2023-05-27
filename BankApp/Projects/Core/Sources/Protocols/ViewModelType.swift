//
//  ViewModelType.swift
//  Core
//
//  Created by devxsby on 2023/05/27.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
