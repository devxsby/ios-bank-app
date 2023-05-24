//
//  BankingSearchView.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

final public class BankingSearchView: UIView {
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.icnSearch.image
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 14)
        textField.textColor = DSKitAsset.Colors.gray300.color
        textField.placeholder = I18N.ServiceFeature.searchBank
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
//        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    // MARK: - Initialization
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension BankingSearchView {
    
    private func setUI() {
        containerView.backgroundColor = DSKitAsset.Colors.gray100.color
        containerView.layer.cornerRadius = 10
    }
    
    private func setLayout() {
        
        addSubview(containerView)
        [searchImageView, textField].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(24)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(searchImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension BankingSearchView {
    
    private func setDelegate() {
        textField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension BankingSearchView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
