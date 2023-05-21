//
//  SplashVC.swift
//  RootFeature
//
//  Created by devxsby on 2023/05/21.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit
import Domain

import SnapKit

public class SplashViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.icnYagom.image
        return imageView
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        addAnimation()
    }
    
    // MARK: - Methods
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(40)
        }
    }
    
    private func addAnimation() {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .autoreverse, animations: {
            print("애니메이션 실행!")
        }, completion: { finished in
            print("애니메이션 종료")
            let tabBarController = TabBarViewController()
            self.navigationController?.pushViewController(tabBarController, animated: true)
            let navigation = UINavigationController(rootViewController: tabBarController)
            SplashViewController.setRootViewController(window: self.view.window!, viewController: navigation, withAnimation: true)
        })
    }
    
    static func setRootViewController(window: UIWindow, viewController: UIViewController, withAnimation: Bool) {
        if !withAnimation {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            return
        }

        if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            UIView.animate(withDuration: 0.4, animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
}
