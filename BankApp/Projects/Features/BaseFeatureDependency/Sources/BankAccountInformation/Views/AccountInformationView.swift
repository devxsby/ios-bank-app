//
//  AccountInformationHeaderView.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public enum AccountInformationAnimationType {
    case comsumption
    case others
}

public final class AccountInformationView: UIView {
    
    // MARK: - UI Components
        
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MainFeature.consumption
        label.textAlignment = .left
        label.textColor = .black
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 20)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.icnNext.image
        return imageView
    }()
    
    public lazy var button: UIButton = {
        var button = UIButton()
        button.setTitle(I18N.MainFeature.history, for: .normal)
        button.titleLabel?.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 14)
        button.setTitleColor(DSKitAsset.Colors.gray400.color, for: .normal)
        button.backgroundColor = DSKitAsset.Colors.gray100.color
        button.layer.cornerRadius = 5
        return button
    }()
        
    // MARK: - Initialization
    
    public init(type: AccountInformationAnimationType = .others) {
        super.init(frame: .zero)
        setUI()
        setLayout(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension AccountInformationView {
    
    private func setUI() {
        backgroundColor = .white
    }
    
    private func setLayout(_ type: AccountInformationAnimationType) {
        
        switch type {
        case .comsumption:
            [titleLabel, button].forEach { self.addSubview($0) }
            
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(38)
                $0.centerY.equalToSuperview()
            }
            
            button.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(38)
                $0.centerY.equalTo(titleLabel)
                $0.width.equalTo(50)
                $0.height.equalTo(30)
            }
            
        case .others:
            [titleLabel, imageView].forEach { self.addSubview($0) }
            
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(24)
                $0.centerY.equalToSuperview()
            }
            
            imageView.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(24)
                $0.centerY.equalTo(titleLabel)
                $0.width.height.equalTo(24)
            }
        }
    }
}

// MARK: - Methods

extension AccountInformationView {
    
    public func addShadow() {
        
    }
    
    public func animateView() {
        
    }
    
    public func setData(_ title: String?) {
        titleLabel.text = title
        imageView.isHidden = (title == I18N.MainFeature.consumption)
    }
}
