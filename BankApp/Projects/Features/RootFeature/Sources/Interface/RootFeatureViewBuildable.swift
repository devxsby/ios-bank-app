//
//  RootFeatureViewBuildable.swift
//  RootFeature
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import BaseFeatureDependency
import Core

public protocol SplashViewControllable: ViewControllable { }

public protocol TabBarControllable: ViewControllable { }

public protocol RootFeatureViewBuildable {
    func makeSplashViewController() -> SplashViewControllable
    func makeTabBarController() -> TabBarControllable
}
