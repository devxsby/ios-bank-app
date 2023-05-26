//
//  AlertViewBuildable.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation
import Core

public protocol AlertViewControllable: ViewControllable { }

public protocol AlertViewBuildable {
    func makeAlertViewController(type: AlertType,
                                 title: String,
                                 customButtonTitle: String,
                                 customAction: (() -> Void)?) -> AlertViewControllable
}
