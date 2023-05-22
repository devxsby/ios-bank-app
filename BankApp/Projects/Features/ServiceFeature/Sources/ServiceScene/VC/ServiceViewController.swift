//
//  ServiceViewController.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/20.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

import ServiceFeatureInterface

public final class ServiceViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerScrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let searchView = BankingSearchView()
    
    private let bankInformationView = BankInformationContainerView()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(DSKitAsset.Images.refresh.image
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(DSKitAsset.Colors.gray500.color), for: .normal)
        button.addTarget(self, action: #selector(refreshButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let loansWaitingBoxView = TellerWaitingBoxView(type: .loans)
    
    private let depositsWaitingBoxView = TellerWaitingBoxView(type: .deposits)
    
    private let showMyWaitlistView = MyWaitlistView()
    
    private let horizontalLineView = UIView()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
}

// MARK: - UI & Layout

extension ServiceViewController {
        
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        title = I18N.ServiceFeature.service
        
        contentView.backgroundColor = .white
        horizontalLineView.backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    private func setLayout() {
        
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(contentView)
        [searchView, bankInformationView,
         refreshButton, loansWaitingBoxView, depositsWaitingBoxView,
         showMyWaitlistView, horizontalLineView].forEach { contentView.addSubview($0) }
        
        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
//            $0.height.equalTo(1000)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(45)
        }
        
        bankInformationView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        refreshButton.snp.makeConstraints {
            $0.top.equalTo(bankInformationView.snp.bottom).offset(15)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(20)
        }
        
        loansWaitingBoxView.snp.makeConstraints {
            $0.top.equalTo(refreshButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        
        depositsWaitingBoxView.snp.makeConstraints {
            $0.top.equalTo(loansWaitingBoxView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        
        showMyWaitlistView.snp.makeConstraints {
            $0.top.equalTo(depositsWaitingBoxView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.top.equalTo(showMyWaitlistView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(4)
        }
    }
}

// MARK: - Methods

extension ServiceViewController {
    
    private func setData() {
        loansWaitingBoxView.setData(0, .loans)
        depositsWaitingBoxView.setData(0, .deposits)
    }
    
    // MARK: - @objc Function
    
    @objc
    private func refreshButtonDidTap() {
        print("refresh button did tap")
    }
}
