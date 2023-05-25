//
//  LifeTipCell.swift
//  MainFeature
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

final public class LifeTipCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MainFeature.getPoint
        label.textAlignment = .left
        label.textColor = DSKitAsset.Colors.gray300.color
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 15)
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 17)
        return label
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

extension LifeTipCell {
    
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
    }
    
    private func setLayout() {
        [titleLabel, subtitleLabel, imageView].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(32)
        }
    }
}

// MARK: - Methods

extension LifeTipCell {
    
    public func setData(_ model: LifeTipModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        imageView.image = model.image
    }
}


public struct LifeTipModel {
    let title: String
    let subtitle: String
    let image: UIImage?
    
    public init(title: String, subtitle: String, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
