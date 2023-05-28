//
//  TabBarViewController.swift
//  RootFeature
//
//  Created by devxsby on 2023/05/19.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import MainFeatureInterface
import ServiceFeatureInterface
import BankingFeatureInterface
import StockFeatureInterface
import SettingFeatureInterface

public final class TabBarController: UITabBarController, TabBarControllable {
    
    // MARK: - Properties
        
    public var factory: MainFeatureViewBuildable & ServiceFeatureViewBuildable
    & BankingFeatureViewBuildable  & StockFeatureViewBuildable & SettingFeatureViewBuildable
    
    // MARK: - Initialization
    
    public init(factory: MainFeatureViewBuildable & ServiceFeatureViewBuildable &
                BankingFeatureViewBuildable  & StockFeatureViewBuildable & SettingFeatureViewBuildable) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setViewControllers()
        setTabBar()
        setupStyle()
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setViewControllers() {
        
        let homeNVC = makeNavigationController(
            image: DSKitAsset.Images.icnHome.image,
            rootViewController: factory.makeHomeViewController().viewController,
            title: I18N.TabBar.home
        )

        let serviceNVC = makeNavigationController(
            image: DSKitAsset.Images.icnService.image,
            rootViewController: factory.makeServiceViewController().viewController,
            title: I18N.TabBar.service
        )
        
        let bankingNVC = makeNavigationController(
            image: DSKitAsset.Images.icnPay.image,
            rootViewController: factory.makeBankingViewController().viewController,
            title: I18N.TabBar.moneyTransfer
        )
        
        let stockNVC = makeNavigationController(
            image: DSKitAsset.Images.icnStock.image,
            rootViewController: factory.makeStockViewController().viewController,
            title: I18N.TabBar.stock
        )
        
        let settingNVC = makeNavigationController(
            image: DSKitAsset.Images.icnMenu.image,
            rootViewController: factory.makeSettingViewController().viewController,
            title: I18N.TabBar.overall
        )
        
        viewControllers = [homeNVC, serviceNVC, bankingNVC, stockNVC, settingNVC]
    }
    
    private func setTabBar() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = DSKitAsset.Colors.gray600.color
        tabBar.unselectedItemTintColor = DSKitAsset.Colors.gray300.color
    }
    
    private func makeNavigationController(image: UIImage?,
                                          rootViewController: UIViewController,
                                          title: String) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        nav.navigationBar.backgroundColor = .white
        nav.tabBarItem.setTitleTextAttributes([.font: DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 10)], for: .normal)
        nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        nav.interactivePopGestureRecognizer?.isEnabled = true
        nav.interactivePopGestureRecognizer?.delegate = self
        return nav
    }
    
    private func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .black, alpha: 0.3, x: 0, y: 0, blur: 1)
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        makeVibrate(degree: .light)
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        makeVibrate()
        if viewController == tabBarController.selectedViewController {
            if let scrollView = findScrollView(in: viewController.view) {
                scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.adjustedContentInset.top), animated: true)
            }
        }
        return true
    }
    
    private func findScrollView(in view: UIView) -> UIScrollView? {
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                return scrollView
            }
            if let scrollView = findScrollView(in: subview) {
                return scrollView
            }
        }
        return nil
    }
}

// MARK: - UIGestureRecognizerDelegate

extension TabBarController: UIGestureRecognizerDelegate { }
