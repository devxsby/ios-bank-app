//
//  AccountInformamtionReusableView.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/27.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public final class AccountInformamtionReusableView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private let containerView = AccountInformationView()
    
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
    }
    
}

// MARK: - UI & Layout

extension AccountInformamtionReusableView {
    
    private func setUI() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 20
    }
    
    private func setLayout() {
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func setData(_ title: String?) {
        containerView.setData(title)
    }
}
