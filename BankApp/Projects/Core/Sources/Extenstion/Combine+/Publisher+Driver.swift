//
//  Publisher+Driver.swift
//  Core
//
//  Created by devxsby on 2023/05/27.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

public typealias Driver<T> = AnyPublisher<T, Never>

public extension Publisher {
    func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }
    
    static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
    
    func mapVoid() -> AnyPublisher<Void, Failure> {
        return self.map { _ in () }
            .eraseToAnyPublisher()
    }
}
