//
//  UITabBar+.swift
//  Core
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public extension UITabBar {
    
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
