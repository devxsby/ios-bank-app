//
//  DIContainer.swift
//  BankApp
//
//  Created by devxsby on 2023/05/19.
//

import Foundation

import Core
import Network
import Domain
import Data

import RootFeature
import MainFeature
import MainFeatureInterface
import ServiceFeature
import ServiceFeatureInterface
import BaseFeatureDependency

public protocol DIContainerInterface {
    func makeTabBarController() -> TabBarViewController
    func makeSplashContoller() -> SplashViewController
    func makeAlertViewController(type: AlertType, title: String, customButtonTitle: String, customAction: (() -> Void)?) -> AlertViewController
}

// TODO: - 잘 안된다 . . . Coordinator 적용하기

public class DIContainer {
    
    static let shared = DIContainer()
    
    private init() { }
}

extension DIContainer: DIContainerInterface {
    
    public func makeTabBarController() -> RootFeature.TabBarViewController {
        let tabBarController = TabBarViewController()
        return tabBarController
    }
    
    public func makeSplashContoller() -> RootFeature.SplashViewController {
        let splashVC = SplashViewController()
//        splashVC.container = self
        return splashVC
    }
    
    public func makeServiceContoller() -> ServiceFeature.ServiceViewController {
        let serviceVC = ServiceViewController()
//        serviceVC.container = self
        return serviceVC
    }
    
    public func makeAlertViewController(type: AlertType,
                                        title: String,
                                        customButtonTitle: String,
                                        customAction: (() -> Void)?) -> BaseFeatureDependency.AlertViewController {
        let alertVC = AlertViewController(alertType: type)
            .setTitle(title)
            .setCustomButtonTitle(customButtonTitle)
        alertVC.customAction = customAction
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        return alertVC
    }
}
