//
//  SceneDelegate.swift
//  BankApp
//
//  Created by devxsby on 2023/05/19.
//

import UIKit

import RootFeature
import DSKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let container = DIContainer.shared
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = container.makeSplashViewController().viewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        callBackgroundImage(false)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        self.callBackgroundImage(true)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        callBackgroundImage(false)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        callBackgroundImage(true)
    }
}

extension SceneDelegate {
    
    private func callBackgroundImage(_ isShow: Bool) {
        
        let TAG_BG_IMG = -101
        let backgroundView = window?.rootViewController?.view.window?.viewWithTag(TAG_BG_IMG)
        
        if isShow {
            if backgroundView == nil {
                let backgroundView = UIView()
                backgroundView.frame = UIScreen.main.bounds
                backgroundView.tag = TAG_BG_IMG
                backgroundView.backgroundColor = .white
                
                let iconImageView = UIImageView()
                iconImageView.frame = CGRect(x: (backgroundView.frame.width - 50) / 2,
                                             y: (backgroundView.frame.height - 50) / 2,
                                             width: 50,
                                             height: 50)
                iconImageView.image = DSKitAsset.Images.icnYagom.image
                backgroundView.addSubview(iconImageView)
                backgroundView.addSubview(iconImageView)
                
                window?.rootViewController?.view.window?.addSubview(backgroundView)
            }
        } else {
            if let backgroundView = backgroundView {
                backgroundView.removeFromSuperview()
            }
        }
    }
}
