//
//  CustomDimmerView.swift
//  DSKit
//
//  Created by devxsby on 2023/05/23.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public class CustomDimmerView: UIView {
    
    // MARK: - Properties
    
    private var view: UIView?
    
    // MARK: - UI Components
    
    private let blurEffect = UIBlurEffect(style: .light)
    private lazy var blurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
    private let dimmerView = UIView()
    
    // MARK: - Initialization
    
    public init(_ vc: UIViewController) {
        super.init(frame: .zero)
        self.view = vc.view
        setViews()
    }
    
    public init(_ view: UIView) {
        super.init(frame: .zero)
        self.view = view
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // dimmerView에 대한 터치 이벤트를 막기 위해 nil을 반환하도록 처리
        return nil
    }
    
}

// MARK: - UI & Layout

extension CustomDimmerView {
    
    private func setViews() {
        dimmerView.backgroundColor = .black.withAlphaComponent(0.55)
        dimmerView.frame = self.view?.frame ?? CGRect()
        blurEffectView.frame = self.view?.frame ?? CGRect()
        [blurEffectView, dimmerView].forEach { self.addSubview($0) }
    }
}
