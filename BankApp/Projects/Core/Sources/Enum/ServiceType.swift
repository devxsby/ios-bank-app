//
//  ServiceType.swift
//  Core
//
//  Created by devxsby on 2023/05/23.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

public enum ServiceType: String {
    case mobileBanking
    
    public var title: String {
        switch self {
        case .mobileBanking: return I18N.ServiceFeature.mobileNumbering
        }
    }
}
