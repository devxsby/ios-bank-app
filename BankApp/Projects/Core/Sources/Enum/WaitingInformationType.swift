//
//  WaitingInformationType.swift
//  Core
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

@frozen
public enum WaitingInformationType: String {
    case waitingCustomers
    case estimatedWaitTime
    case issuanceTime
    
    public var title: String {
        switch self {
        case .waitingCustomers: return I18N.ServiceFeature.waitingCustomers
        case .estimatedWaitTime: return I18N.ServiceFeature.estimatedWaitTimes
        case .issuanceTime: return I18N.ServiceFeature.issuanceTime
        }
    }
}
