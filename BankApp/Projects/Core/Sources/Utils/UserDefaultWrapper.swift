//
//  UserDefaultWrapper.swift
//  Core
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefaultWrapper<T> {
    
    private let key: String
    private let defaultValue: T
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
