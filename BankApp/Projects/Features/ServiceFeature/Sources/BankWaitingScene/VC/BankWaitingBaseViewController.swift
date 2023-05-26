//
//  MobileNumberingBaseViewController.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import Domain
import DSKit

import SnapKit
import BaseFeatureDependency
import ServiceFeatureInterface

public class BankWaitingBaseViewController: UIViewController, ServiceViewControllable {
    
    // MARK: - Properties
    
    public var factory: AlertViewBuildable
    
    @UserDefaultWrapper<Bool>(key: "isWaiting", defaultValue: false)
    public var isWaiting: Bool {
        didSet {
            waitButton.isSelected = isWaiting
            waitButton.backgroundColor = isWaiting ? DSKitAsset.Colors.gray300.color : DSKitAsset.Colors.blue.color
        }
    }
    
    private var isButtonEnabled: Bool = true {
        didSet {
            waitButton.isEnabled = isButtonEnabled
        }
    }
    
    // MARK: - UI Components
    
    private let containerScrollView = UIScrollView()
    private let contentView = UIView()
    
    private let waitStatusView = WaitingStatusDisplayView()
    
    private let notificationView = WaitingNotificationView()
    
    public lazy var waitButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.titleLabel?.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 16)
        button.backgroundColor = DSKitAsset.Colors.blue.color
        button.setTitle(I18N.ServiceFeature.waiting, for: .normal)
        button.setTitle(I18N.ServiceFeature.cancelWaiting, for: .selected)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(waitButtonDidTap), for: .touchUpOutside)
        return button
    }()
    
    // MARK: - Initialization
    
    init(factory: AlertViewBuildable) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        initialButtonState()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(isWaiting)
    }
}

// MARK: - UI & Layout

extension BankWaitingBaseViewController {
    
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

extension BankWaitingBaseViewController {
    
    private func initialButtonState() {
        isWaiting = isWaiting // 기존 상태
    }
    
    @objc
    public func waitButtonDidTap() {
        if isButtonEnabled {
            isButtonEnabled = false
            isWaiting ? presentAlertVC() : performWaiting()
        }
    }
    
    private func presentAlertVC() {
        
        let alertVC = factory.makeAlertViewController(type: .cancelWaiting,
                                                      title: I18N.ServiceFeature.Alert.cancelPopup,
                                                      customButtonTitle: I18N.ServiceFeature.cancelWaiting,
                                                      customAction: {
            self.cancelWaiting()
        }).viewController
        
        makeVibrate()
        present(alertVC, animated: true)
        
        isButtonEnabled = true // 버튼을 즉시 다시 활성화
    }
    
    private func performWaiting() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // 클릭 간격 제한
            self.isButtonEnabled = true
        }
        isWaiting = true
        showToast(message: I18N.ServiceFeature.successWaiting)
    }
    
    private func cancelWaiting() {
        isWaiting = false
        isButtonEnabled = true // 버튼을 즉시 다시 활성화
    }
}
