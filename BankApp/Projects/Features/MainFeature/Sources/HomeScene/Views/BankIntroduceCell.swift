//
//  BankIntroduceCell.swift
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

final public class BankIntroduceCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 20)
        return label
    }()
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.icnNext.image
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

extension BankIntroduceCell {
    
    private func setUI() {
        layer.cornerRadius = 20
        backgroundColor = .white
    }
    
    private func setLayout() {
        [imageView, titleLabel].forEach { contentView.addSubview($0) }
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}
// MARK: - Methods

extension BankIntroduceCell {
    
    public func setData(_ model: BankIntroduceModel) {
        titleLabel.text = model.name
    }
}

public struct BankIntroduceModel {
    let name: String
    
    public init(name: String) {
        self.name = name
    }
}
