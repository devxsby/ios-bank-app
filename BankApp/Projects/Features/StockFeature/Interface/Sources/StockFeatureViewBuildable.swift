//
//  StockFeatureViewBuildable.swift
//  StockFeatureInterface
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import BaseFeatureDependency
import Core

public protocol StockViewControllable: ViewControllable { }

public protocol StockFeatureViewBuildable {
    func makeStockViewController() -> StockViewControllable
}
