//
//  BankingServiceType.swift
//  Core
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

@frozen
public enum BankingServiceType: String {
    case loan
    case deposit
    
    public var title: String {
        switch self {
        case .loan: return I18N.ServiceFeature.loan
        case .deposit: return I18N.ServiceFeature.deposit
        }
    }
    
    public var teller: String {
        return title + " " + I18N.ServiceFeature.teller
    }
    
    public var tabIndex: Int {
        switch self {
        case .loan: return 0
        case .deposit: return 1
        }
    }
}
