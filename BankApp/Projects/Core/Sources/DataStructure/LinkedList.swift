//
//  LinkedList.swift
//  Core
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var count: Int {
        var node = head
        var count = 0
        while node != nil {
            count += 1
            node = node?.next
        }
        return count
    }
    
    func append(_ value: T) {
        let newNode = Node(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
    
    func removeFirst() -> T? {
        let value = head?.value
        head = head?.next
        if head == nil {
            tail = nil
        }
        return value
    }
}
