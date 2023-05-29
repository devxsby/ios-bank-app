//
//  SplashViewController.swift
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

public final class SplashViewController: UIViewController, SplashViewControllable {
    
    // MARK: - Properties
    
    public var factory: RootFeatureViewBuildable
        
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.icnYagom.image
        return imageView
    }()
    
    // MARK: - Initialization
    
    public init(factory: RootFeatureViewBuildable) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
    
    private func addAnimation() {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .autoreverse, animations: {
            // TODO: - 스플래시 애니메이션 넣기
        }, completion: { _ in
            guard let tabBarController = self.factory.makeTabBarController().viewController
                    as? UITabBarController else { return }
            tabBarController.selectedIndex = 1
            SplashViewController.setRootViewController(window: self.view.window!, viewController: tabBarController, withAnimation: true)
        })
    }
}
