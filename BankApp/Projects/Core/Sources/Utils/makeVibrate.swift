//
//  makeVibrate.swift
//  Core
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public extension UIViewController {
    
  func makeVibrate(degree: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
}

public extension UIView {
    
    func makeVibrate(degree: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
}
