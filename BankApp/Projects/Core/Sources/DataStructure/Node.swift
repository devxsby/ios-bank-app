//
//  Node.swift
//  Core
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

final class Node<T> {
    var value: T
    var next: Node<T>?

    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}
