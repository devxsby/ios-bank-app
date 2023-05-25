//
//  HomeFooterView.swift
//  MainFeature
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public final class HomeFooterView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private lazy var displaySettingButton: UIButton = {
        let button = UIButton()
        button.tintColor = DSKitAsset.Colors.gray400.color
        button.backgroundColor = DSKitAsset.Colors.gray200.color
        var titleAttr = AttributedString(.init(I18N.MainFeature.screenSettings))
        titleAttr.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 15)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = titleAttr
        config.imagePadding = 5
        config.image = DSKitAsset.Images.icnSetting.image
        button.configuration = config
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var addAssetsButton: UIButton = {
        let button = UIButton()
        button.tintColor = DSKitAsset.Colors.gray400.color
        button.backgroundColor = DSKitAsset.Colors.gray200.color
        var titleAttr = AttributedString(.init(I18N.MainFeature.addingAssets))
        titleAttr.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 15)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = titleAttr
        config.image = DSKitAsset.Images.icnPlus.image
        button.configuration = config
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            displaySettingButton,
            addAssetsButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        var button = UIButton()
        button.setTitle(I18N.MainFeature.viewPrivacyPolicy, for: .normal)
        button.titleLabel?.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 14)
        button.setTitleColor(DSKitAsset.Colors.gray300.color, for: .normal)
        return button
    }()
        
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI & Layout

extension HomeFooterView {
    
    private func setUI() {
        backgroundColor = .clear
    }
    
    private func setLayout() {
        [buttonsStack, privacyPolicyButton].forEach { self.addSubview($0) }
        
        displaySettingButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(55)
        }
        
        addAssetsButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(55)
        }
        
        buttonsStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
        privacyPolicyButton.snp.makeConstraints {
            $0.top.equalTo(buttonsStack.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
}
