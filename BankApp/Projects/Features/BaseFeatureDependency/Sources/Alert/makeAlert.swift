//
//  makeAlert.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core

extension UIViewController {
    
    public func makeAlertViewController(type: AlertType,
                                        title: String,
                                        customButtonTitle: String,
                                        customAction: (() -> Void)?) -> AlertViewController {
        let alertVC = AlertViewController(alertType: type)
            .setTitle(title)
            .setCustomButtonTitle(customButtonTitle)
        alertVC.customAction = customAction
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        
        makeVibrate()
        
        return alertVC
    }
}
