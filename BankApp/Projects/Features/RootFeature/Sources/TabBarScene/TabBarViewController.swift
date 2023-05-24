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

public final class TabBarViewController: UITabBarController {
        
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
            rootViewController: HomeViewController(),
            title: I18N.TabBar.home
        )

        let serviceNVC = makeNavigationController(
            image: DSKitAsset.Images.icnService.image,
            rootViewController: ServiceViewController(),
            title: I18N.TabBar.service
        )
        
        let bankingNVC = makeNavigationController(
            image: DSKitAsset.Images.icnPay.image,
            rootViewController: BankingViewController(),
            title: I18N.TabBar.moneyTransfer
        )
        
        let stockNVC = makeNavigationController(
            image: DSKitAsset.Images.icnStock.image,
            rootViewController: StockViewController(),
            title: I18N.TabBar.stock
        )
        
        let settingNVC = makeNavigationController(
            image: DSKitAsset.Images.icnMenu.image,
            rootViewController: SettingViewController(),
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
//        nav.isNavigationBarHidden = true
//        nav.navigationBar.isHidden = true
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

extension TabBarViewController: UITabBarControllerDelegate {
    
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

extension TabBarViewController: UIGestureRecognizerDelegate { }
