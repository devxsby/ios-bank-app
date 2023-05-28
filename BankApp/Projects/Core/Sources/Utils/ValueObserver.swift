//
//  ValueObserver.swift
//  Core
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

@propertyWrapper
public class ValueObserver<T> {
    
    private var value: T
    private let name: String
    
    public var wrappedValue: T {
        get { value }
        set {
            value = newValue
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: newValue)
        }
    }

    public var projectedValue: ValueObserver<T> {
        return self
    }

    public init(wrappedValue: T, name: String) {
        self.value = wrappedValue
        self.name = name
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(valueDidChange(_:)),
                                               name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func valueDidChange(_ notification: Notification) {
        guard let newValue = notification.object as? T else { return }
        value = newValue
    }
}
