//
//  WaitingStatusDisplayView.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

final public class WaitingStatusDisplayView: UIView {
    
    // MARK: - UI Components
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.isHidden = true
        return indicator
    }()
    
    let waitingAnimationView = WaitingAnimationView(.basic)
    let waitingCustomersCountView = SingleWaitStatusView(.loan, .waitingCustomers)
    let estimatedWaitTimeView = SingleWaitStatusView(.loan, .estimatedWaitTime)
    let issuanceTimeView = SingleWaitStatusView(.loan, .issuanceTime)
    
    private let bankNameLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.sampleBankName
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 15)
        label.textColor = DSKitAsset.Colors.gray600.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            waitingCustomersCountView,
            estimatedWaitTimeView,
            issuanceTimeView
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Initialization
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension WaitingStatusDisplayView {
    
    private func setUI() {
        backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    private func setLayout() {
        self.addSubview(activityIndicator)
        [waitingAnimationView, stackView,  bankNameLabel].forEach { self.addSubview($0) }
        
        activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        waitingAnimationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(220)
        }
        
        bankNameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalTo(stackView.snp.trailing).inset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.bottom.equalTo(bankNameLabel.snp.top).inset(-20)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension WaitingStatusDisplayView {
    
    func loadingView(isActivate: Bool) {
        if isActivate {
            waitingAnimationView.isHidden = isActivate
            stackView.isHidden = isActivate
            bankNameLabel.isHidden = isActivate
            
            activityIndicator.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.activityIndicator.stopAnimating()
                self.waitingAnimationView.isHidden = !isActivate
                self.stackView.isHidden = !isActivate
                self.bankNameLabel.isHidden = !isActivate
            }
        }
    }
}

