//
//  Queue.swift
//  Core
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

class Queue<T> {
    private var elements = [T]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func enqueue(_ element: T) {
        elements.append(element)
    }
    
    func dequeue() -> T? {
        if elements.isEmpty {
            return nil
        }
        return elements.removeFirst()
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    func clear() {
        elements.removeAll()
    }
}
