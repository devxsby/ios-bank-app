//
//  WaitingAnimationStyle.swift
//  Core
//
//  Created by devxsby on 2023/05/29.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

@frozen
public enum WaitingAnimationStyle {
    case basic
    case animated(fillIndex: Int)
}