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

// TODO: - 홈 뷰 하단 소비탭 애니메이션 부분 확장성을 고려해서 imageview 말고 button도 추가하고 타입으로 선택해서 레이아웃 그리도록 하기

public final class AccountInformationHeaderView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private let cornerView = UIView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
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
        
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    public override func prepareForReuse() {
        super.prepareForReuse()
//        self.prepare(title: nil)
    }
    
}

// MARK: - UI & Layout

extension AccountInformationHeaderView {
    
    private func prepare(title: String?) {
        self.titleLabel.text = title
    }
    
    private func setUI() {
        layer.cornerRadius = 20
        backgroundColor = .white
        cornerView.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubview(cornerView)
        [titleLabel, imageView].forEach { self.addSubview($0) }
        
        cornerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
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
    
    public func setData(_ title: String?) {
        titleLabel.text = title
    }
}
