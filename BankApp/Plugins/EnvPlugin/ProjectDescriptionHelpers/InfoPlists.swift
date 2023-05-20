//
//  InfoPlists.swift
//  EnvPlugin
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription

public extension Project {
    static let appInfoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.devxsby.BankApp",
        "CFBundleDisplayName": "BankApp",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "UIAppFonts": [
            "Item 0": "SpoqaHanSansNeo-Bold",
            "Item 1": "SpoqaHanSansNeo-Light",
            "Item 2": "SpoqaHanSansNeo-Medium",
            "Item 3": "SpoqaHanSansNeo-Regular",
            "Item 4": "SpoqaHanSansNeo-Thin"
        ],
        "App Transport Security Settings": ["Allow Arbitrary Loads": true],
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "ITSAppUsesNonExemptEncryption": false,
        "UIUserInterfaceStyle": "Light"
    ]
    
}
