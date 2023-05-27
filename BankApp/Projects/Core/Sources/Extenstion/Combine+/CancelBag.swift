//
//  CancelBag.swift
//  Core
//
//  Created by devxsby on 2023/05/27.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Combine

public class CancelBag {
    public var subscriptions = Set<AnyCancellable>()
    
    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    public init() { }
}

extension AnyCancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
