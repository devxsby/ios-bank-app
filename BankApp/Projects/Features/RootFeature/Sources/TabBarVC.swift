//
//  Sample.swift
//  RootFeature
//
//  Created by devxsby on 2023/05/19.
//

import UIKit

import DSKit

import SplashFeature
import SplashFeatureInterface
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

public class TabBarController: UITabBarController {
        
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setTabBar()
    }
    
    // MARK: - Methods
    
    private func setViewControllers() {
        
        let homeNVC = makeNavigationController(
            image: DSKitAsset.Images.icnHome.image,
            rootViewController: HomeViewController(),
            title: "홈"
        )

//        let serviceNVC = makeNavigationController(
//            image: DSKitAsset.Images.icnService.image,
//            rootViewController: ServiceViewContoller(),
//            title: "서비스"
//        )
        
        let bankingNVC = makeNavigationController(
            image: DSKitAsset.Images.icnPay.image,
            rootViewController: BankingViewController(),
            title: "송금"
        )
        
        let stockNVC = makeNavigationController(
            image: DSKitAsset.Images.icnStock.image,
            rootViewController: StockViewController(),
            title: "주식"
        )
        
        let settingNVC = makeNavigationController(
            image: DSKitAsset.Images.icnMenu.image,
            rootViewController: SettingViewController(),
            title: "전체"
        )
        
        viewControllers = [homeNVC, bankingNVC, stockNVC, settingNVC]
    }
    
    private func setTabBar() {
        tabBar.backgroundColor = .white
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
        nav.isNavigationBarHidden = true
        nav.navigationBar.isHidden = true
        nav.tabBarItem.setTitleTextAttributes([.font: DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 10)], for: .normal)
        nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        
        nav.interactivePopGestureRecognizer?.isEnabled = true
        nav.interactivePopGestureRecognizer?.delegate = self
        return nav
    }
}

extension TabBarController: UIGestureRecognizerDelegate { }

