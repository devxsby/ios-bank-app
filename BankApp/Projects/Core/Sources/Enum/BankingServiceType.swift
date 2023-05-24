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
    case deposits
    case loans
    
    public var title: String {
        switch self {
        case .deposits: return I18N.ServiceFeature.deposits
        case .loans: return I18N.ServiceFeature.loans
        }
    }
    
    public var teller: String {
        return title + I18N.ServiceFeature.teller
    }
}
