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
import BankingFeature
import BankingFeatureInterface
import StockFeature
import StockFeatureInterface
import SettingFeature
import SettingFeatureInterface
import BaseFeatureDependency

typealias Features = RootFeatureViewBuildable & MainFeatureViewBuildable & BankingFeatureViewBuildable & StockFeatureViewBuildable & SettingFeatureViewBuildable & AlertViewBuildable

public class DIContainer: ServiceFeatureViewBuildable {
    
    static let shared = DIContainer()
    
    private init() { }
    
    private let serviceRepository = ServiceRepository()
    private let customerGenerator = CustomerGenerator()
    private lazy var servieUsecase = DefaultServiceUseCase(repository: serviceRepository,
                                                           customerGenerator: customerGenerator)
    private lazy var serviceViewModel = ServiceViewModel(usecase: servieUsecase)
}

extension DIContainer: Features {
    
    public func makeSplashViewController() -> RootFeature.SplashViewControllable {
        let splashVC = SplashViewController(factory: self)
        return splashVC
    }
    
    public func makeTabBarController() -> RootFeature.TabBarControllable {
        let tabBarController = TabBarController(factory: self)
        return tabBarController
    }
    
    public func makeHomeViewController() -> MainFeatureInterface.HomeViewControllable {
        let repository = HomeRepository()
        let usecase = DefaultHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: usecase)
        let homeVC = HomeViewController(viewModel: viewModel)
        return homeVC
    }
        
    public func makeServiceViewController() -> ServiceFeatureInterface.ServiceViewControllable {
        let serviceVC = ServiceViewController(factory: self, viewModel: serviceViewModel)
        return serviceVC
    }

    public func makeBankWaitingViewController() -> ServiceFeatureInterface.ServiceViewControllable {
        let bankingWaitingVC = BankWaitingDetailViewController(factory: self, viewModel: serviceViewModel)
        return bankingWaitingVC
    }
    
    public func makeBankingViewController() -> BankingFeatureInterface.BankingViewControllable {
        let bankingVC = BankingViewController()
        return bankingVC
    }
    
    public func makeStockViewController() -> StockFeatureInterface.StockViewControllable {
        let stockVC = StockViewController()
        return stockVC
    }
    
    public func makeSettingViewController() -> SettingFeatureInterface.SettingViewControllable {
        let settingVC = SettingViewController()
        return settingVC
    }
    
    public func makeAlertViewController(type: AlertType,
                                        title: String,
                                        customButtonTitle: String,
                                        customAction: (() -> Void)?) -> BaseFeatureDependency.AlertViewControllable {
        let alertVC = AlertViewController(alertType: type)
            .setTitle(title)
            .setCustomButtonTitle(customButtonTitle)
        alertVC.customAction = customAction
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        return alertVC
    }
}
