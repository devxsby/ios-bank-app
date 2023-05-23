//
//  MobileNumberingBaseViewController.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public class NumberingBaseViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerScrollView = UIScrollView()
    private let contentView = UIView()
    
    private let waitStatusView = WaitingStatusDisplayView()
    
    private let notificationView = WaitingNotificationView()
    
    private lazy var waitButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = DSKitAsset.Colors.blue.color
        button.setTitle(I18N.ServiceFeature.waiting, for: .normal)
        button.setTitle(I18N.ServiceFeature.cancelWaiting, for: .disabled)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(waitButtonDidTap), for: .touchUpOutside) // FIX: 클릭 안됨 -> delegate로 전달
        return button
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension NumberingBaseViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        waitStatusView.layer.cornerRadius = 20
        containerScrollView.showsVerticalScrollIndicator = false
    }
    
    private func setLayout() {
        [containerScrollView, waitButton].forEach { view.addSubview($0) }
        containerScrollView.addSubview(contentView)
    
        [waitStatusView, notificationView].forEach { contentView.addSubview($0) }
        
        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(waitButton.snp.top).offset(10)
        }
        
        waitButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        waitStatusView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        notificationView.snp.makeConstraints {
            $0.top.equalTo(waitStatusView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(20)
            $0.height.equalTo(250)
        }
    }
}

// MARK: - Methods

extension NumberingBaseViewController {
    
    @objc
    private func waitButtonDidTap() {
//        waitButton.isSelected.toggle()
//        print("대기하기 버튼 클릭")
    }
}
