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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DSKitAsset.Images.imgPeoples.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let waitingCustomersStatusView = SingleWaitStatusView(.loan, .waitingCustomers)
    private let estimatedWaitTimeStatusView = SingleWaitStatusView(.loan, .estimatedWaitTime)
    private let issuanceTimeStatusView = SingleWaitStatusView(.loan, .issuanceTime)
    
    private let bankNameLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.sampleBankName
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 16)
        label.textColor = DSKitAsset.Colors.gray600.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            waitingCustomersStatusView,
            estimatedWaitTimeStatusView,
            issuanceTimeStatusView
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
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
        [imageView, stackView,  bankNameLabel].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(180)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        bankNameLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.trailing.equalTo(stackView.snp.trailing).inset(20)
        }
    }
}

// MARK: - Methods

extension WaitingStatusDisplayView {
    
    // TODO: - viewwillappear 노티받으면 setData 업데이트 하기
    // TODO: - 예금, 대출 다른 뷰컨으로 상속 시키는 법?
    private func setData() {
        waitingCustomersStatusView.setData(.deposit, .waitingCustomers, 5)
        estimatedWaitTimeStatusView.setData(.deposit, .estimatedWaitTime, 10)
        issuanceTimeStatusView.setData(.deposit, .issuanceTime, 0)

    }
}

