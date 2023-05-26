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
    case loans
    case deposits
    
    public var title: String {
        switch self {
        case .loans: return I18N.ServiceFeature.loans
        case .deposits: return I18N.ServiceFeature.deposits
        }
    }
    
    public var teller: String {
        return title + " " + I18N.ServiceFeature.teller
    }
    
    public var tabIndex: Int {
        switch self {
        case .loans: return 0
        case .deposits: return 1
        }
    }
}
