//
//  SingleWaitStatusView.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/23.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

final class SingleWaitStatusView: UIView {
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 16)
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .right
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 16)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initialization

    public init(_ bankingServiceType: BankingServiceType = .loan, _ waitingInformationType: WaitingInformationType) {
        super.init(frame: .zero)
        setUI(bankingServiceType)
        setData(bankingServiceType, waitingInformationType)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension SingleWaitStatusView {
    
    private func setUI(_ type: BankingServiceType) {
        titleLabel.text = "\(type.title) \(I18N.ServiceFeature.waitingCustomers)"
    }
    
    private func setLayout() {
        
        [titleLabel, subtitleLabel].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(titleLabel)
        }
    }
}

// MARK: - Methods

extension SingleWaitStatusView {
    
    public func setData(_ bankingServiceType: BankingServiceType = .loan,
                        _ waitingInformationType: WaitingInformationType = .waitingCustomers,
                        _ value: String? = nil) {
        switch waitingInformationType {
        case .waitingCustomers:
            titleLabel.text = "\(bankingServiceType.title) \(I18N.ServiceFeature.waitingCustomers)"
            subtitleLabel.text = value == "0" ? "-" : "\(value ?? "-") \(I18N.ServiceFeature.peopleCount)"
        case .estimatedWaitTime:
            titleLabel.text = I18N.ServiceFeature.estimatedWaitTimes
            subtitleLabel.text = value == "0" ? "-" : "\(value ?? "-") \(I18N.ServiceFeature.minute)"
        case .issuanceTime:
            titleLabel.text = I18N.ServiceFeature.issuanceTime
            subtitleLabel.text = value != nil ? value! : "-"
        }
    }
}
