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
import SplashFeature
import SplashFeatureInterface
import BaseFeatureDependency

public protocol DIContainerInterface {
    func makeTabBarController() -> TabBarController
    func makeSplashContoller() -> SplashViewController
}

public class DIContainer {
    
    static let shared = DIContainer()
    
    private init() { }
}

extension DIContainer: DIContainerInterface {
    
    public func makeTabBarController() -> TabBarController {
        let tabBarController = TabBarController()
        return tabBarController
    }
    
    public func makeSplashContoller() -> SplashViewController {
        let splashVC = SplashViewController()
//        splashVC.container = self
        return splashVC
    }
}
