//
//  ViewControllable.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/26.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public protocol ViewControllable {
    var viewController: UIViewController { get }
}

public extension ViewControllable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
