//
//  MobileNumberingTypeCell.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

final public class MobileNumberingTypeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? UIColor.black :  DSKitAsset.Colors.gray300.color
            selectedLineView.backgroundColor = isSelected ? DSKitAsset.Colors.blue.color : .white
        }
    }
    
    // MARK: - UI Components
    
    private var menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DSKitAsset.Colors.gray300.color
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 15)
        return label
    }()
    
    private let selectedLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension MobileNumberingTypeCell {
    
    private func setLayout() {
        [menuLabel, selectedLineView].forEach { contentView.addSubview($0) }
        contentView.addSubview(menuLabel)
        
        menuLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        selectedLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(3)
        }
    }
}

// MARK: - Methods

extension MobileNumberingTypeCell {
    
    public func dataBind(menuLabel: String) {
        self.menuLabel.text = menuLabel
    }
}
