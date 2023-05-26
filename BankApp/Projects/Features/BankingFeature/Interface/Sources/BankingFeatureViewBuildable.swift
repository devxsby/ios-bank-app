//
//  BankingFeatureViewBuildable.swift
//  BankingFeatureInterface
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import BaseFeatureDependency
import Core

public protocol BankingViewControllable: ViewControllable { }

public protocol BankingFeatureViewBuildable {
    func makeBankingViewController() -> BankingViewControllable
}
