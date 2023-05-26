//
//  ServiceFeatureViewBuildable.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import BaseFeatureDependency
import Core

public protocol ServiceViewControllable: ViewControllable { }

public protocol ServiceFeatureViewBuildable {
    func makeServiceViewController() -> ServiceViewControllable
    func makeBankWaitingViewController() -> ServiceViewControllable
}
