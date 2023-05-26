//
//  MainFeatureViewBuildable.swift
//  MainFeatureInterface
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import BaseFeatureDependency
import Core

public protocol HomeViewControllable: ViewControllable { }

public protocol MainFeatureViewBuildable {
    func makeHomeViewController() -> HomeViewControllable
}
