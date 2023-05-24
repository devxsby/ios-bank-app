//
//  SingleTouchButton.swift
//  DSKit
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

// MARK: - Protocol + extension

protocol DisableDoubleClickButton: AnyObject {
    var isEnabled: Bool { get set }
}

extension DisableDoubleClickButton where Self: UIButton {
    func disableDoubleClick() {
        isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isEnabled = true
        }
    }
}

public final class SingleTouchButton: UIButton, DisableDoubleClickButton {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - @objc Function

extension SingleTouchButton {
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        disableDoubleClick()
    }
}
