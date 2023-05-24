//
//  hideKeyboardWhenTappedAround.swift
//  Core
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
