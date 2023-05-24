//
//  CustomVisualEffectView.swift
//  DSKit
//
//  Created by devxsby on 2023/05/23.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public class CustomVisualEffectView: UIVisualEffectView {
    
    // MARK: - Properties
    
    private var theEffect: UIVisualEffect
    private var customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
    
    // MARK: - Initialization
    
    public init(effect: UIVisualEffect, intensity: CGFloat) {
        self.theEffect = effect
        self.customIntensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animator?.stopAnimation(true)
    }

    // MARK: - View Life Cycle
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
//        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = theEffect
        }
        animator?.fractionComplete = customIntensity
    }
}
