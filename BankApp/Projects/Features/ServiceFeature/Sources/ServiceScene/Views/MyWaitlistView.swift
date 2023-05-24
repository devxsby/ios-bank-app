//
//  MyWaitlistView.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public protocol MyWaitlistViewDelegate: AnyObject {
    func didPressWaitlistView()
}

final public class MyWaitlistView: UIView {
    
    // MARK: - Properties
    
    public weak var delegate: MyWaitlistViewDelegate?
    
    // MARK: - UI Components
    
    private let topLineView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.showMyWaitlist
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 16)
        label.textColor = DSKitAsset.Colors.gray300.color
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.icnNext.image
        return imageView
    }()
    
    private let bottomLineView = UIView()
    
    // MARK: - Initialization
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension MyWaitlistView {
    
    private func setUI() {
        backgroundColor = .white
        topLineView.backgroundColor = DSKitAsset.Colors.gray100.color
        bottomLineView.backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    private func setLayout() {
        
        [topLineView, titleLabel, imageView, bottomLineView].forEach { self.addSubview($0) }
        
        topLineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

// MARK: - Methods

extension MyWaitlistView {
    
    private func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.delaysTouchesEnded = false
        tapGestureRecognizer.delaysTouchesBegan = false
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - @objc Function
    
    @objc
    private func handleTap() {
        
        backgroundColor = DSKitAsset.Colors.gray100.color.withAlphaComponent(0.3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.backgroundColor = .white
            self.delegate?.didPressWaitlistView()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension MyWaitlistView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
