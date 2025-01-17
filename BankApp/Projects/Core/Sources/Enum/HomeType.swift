//
//  HomeType.swift
//  Core
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

@frozen
public enum HomeItemType: Int {
    case bankIntroduce
    case point
    case assets
    case investments
    case consumption
    case life
    
    public var reuseIdentifier: String {
        switch self {
        case .bankIntroduce: return "BankIntroduceCell"
        case .point: return "EarnPointCell"
        case .assets: return "AssetsCell"
        case .investments: return "InvestmentsCell"
        case .consumption: return "ConsumptionCell"
        case .life: return "LifeTipCell"
        }
    }
}
