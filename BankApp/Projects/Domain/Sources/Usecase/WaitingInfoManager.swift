//
//  WaitingInfoManager.swift
//  Domain
//
//  Created by devxsby on 2023/05/28.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

import Core

public final class WaitingInfoManager {
    
    // MARK: - Properties
    
    public static let shared = WaitingInfoManager()
    
    @ValueObserver(name: "depositCountDidChange")
    public var depositCount: Int = 0
    public var depositTime: Double = 0
    
    @ValueObserver(name: "loanCountDidChange")
    public var loanCount: Int = 0
    public var loanTime: Double = 0
    
    public var waitingStatus: Bool = false
    public var issuanceTime: Date = Date.now
    
    // MARK: - Initialization
    
    private init() { }
}
