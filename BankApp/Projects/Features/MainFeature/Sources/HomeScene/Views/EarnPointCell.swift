//
//  EarnPointCell.swift
//  MainFeatureInterface
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

// TODO: - 셀이 아니라 헤더로 바꾸기

final public class EarnPointCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.imgHeader.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MainFeature.getPoint
        label.textAlignment = .left
        label.textColor = .black
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 18)
        return label
    }()
    
    private let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.imgPointFriend.image
        imageView.contentMode = .scaleAspectFill
        return imageView
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

extension EarnPointCell {
    
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        backImageView.layer.cornerRadius = 20
    }
    
    private func setLayout() {
        [backImageView, centerImageView, titleLabel].forEach { self.addSubview($0) }
        
        backImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        centerImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(24)
        }
    }
}

// MARK: - Methods

extension EarnPointCell {
    
    public func setData(_ model: EarnPointModel) {
        titleLabel.text = model.title
    }
}


public struct EarnPointModel {
    let title: String
    
    public init(title: String) {
        self.title = title
    }
}
