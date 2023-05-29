//
//  AccountInformationCell.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import Domain
import DSKit

import SnapKit

public class AccountInformationCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let cornerView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = DSKitAsset.Colors.gray400.color.withAlphaComponent(0.8)
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 14)
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = DSKitAsset.Colors.gray500.color
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 16)
        return label
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var button: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 14)
        button.setTitleColor(DSKitAsset.Colors.gray400.color, for: .normal)
        button.backgroundColor = DSKitAsset.Colors.gray100.color
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension AccountInformationCell {
    
    private func setUI() {
        layer.cornerRadius = 20
        backgroundColor = .white
        cornerView.layer.masksToBounds = true
        cornerView.backgroundColor = .white
    }
    
    private func setLayout() {
        contentView.addSubview(cornerView)
        [imageView, labelsStack, button].forEach { contentView.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        cornerView.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        labelsStack.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.centerY.equalTo(imageView)
        }
        
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(imageView)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
    }
}

// MARK: - Methods

extension AccountInformationCell {
    
    public func setData(_ model: AccountInformation) {
        imageView.image = model.image
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        button.setTitle(model.buttonTitle, for: .normal)
        
        checkButtonHidden(with: model.buttonTitle)
        checkStockLabel(with: subtitleLabel)
    }
    
    private func checkButtonHidden(with buttonTitle: String?) {
        if let title = buttonTitle, !title.isEmpty {
            button.isHidden = false
        } else {
            button.isHidden = true
        }
    }
    
    private func checkStockLabel(with subtitle: UILabel) {
        if subtitleLabel.text?.contains(" ") == true {
            let subtitle = subtitleLabel.text?.components(separatedBy: " ")
            if subtitle?[1] == "+" {
                subtitleLabel.textColor = DSKitAsset.Colors.warning.color
                subtitleLabel.partColorChange(targetString: subtitle?[0] ?? "", textColor: .black)
            }
            if subtitle?[1] == "-" {
                subtitleLabel.textColor = DSKitAsset.Colors.blue.color
                subtitleLabel.partColorChange(targetString: subtitle?[0] ?? "", textColor: .black)
            }
        }
    }
}
