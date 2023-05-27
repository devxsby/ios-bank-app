//
//  Publisher+withUnretained.swift
//  Core
//
//  Created by devxsby on 2023/05/27.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

public extension Publisher {
    func withUnretained<T: AnyObject>(_ object: T) -> Publishers.CompactMap<Self, (T, Self.Output)> {
        compactMap { [weak object] output in
            guard let object = object else {
                return nil
            }
            return (object, output)
        }
    }
}
