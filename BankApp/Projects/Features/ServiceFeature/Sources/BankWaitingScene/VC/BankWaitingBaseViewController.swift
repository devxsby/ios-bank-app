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
    
    public let factory: AlertViewBuildable
    public let viewModel: ServiceViewModel
    
    @UserDefaultWrapper<Bool>(key: "isWaiting", defaultValue: false)
    public var isWaiting: Bool {
        didSet {
            waitButton.isSelected = isWaiting
            waitButton.backgroundColor = isWaiting ? DSKitAsset.Colors.gray300.color.withAlphaComponent(0.5) : DSKitAsset.Colors.blue.color
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
    let waitStatusView = WaitingStatusDisplayView()
    let notificationView = WaitingNotificationView()
    
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
    
    init(factory: AlertViewBuildable, viewModel: ServiceViewModel) {
        self.factory = factory
        self.viewModel = viewModel
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
        bindViewModels()
    }
}

// MARK: - UI & Layout

extension BankWaitingBaseViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        waitButton.layer.applyShadow(color: .white, alpha: 1, x: 0, y: -10, blur: 10)
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
            $0.bottom.equalToSuperview().offset(10)
            $0.height.equalTo(230)
        }
    }
    
    private func calculateAnimationState(for count: Int?) -> WaitingAnimationStyle {
        guard let count = count else { return .basic }
        if count <= 1 {
            return .animated(fillIndex: 2)
        } else if count <= 5 {
            return .animated(fillIndex: 1)
        } else {
            return .animated(fillIndex: 0)
        }
    }
}

// MARK: - Methods

extension BankWaitingBaseViewController {
    
    private func bindViewModels() {
        
        viewModel.depositCountDidChange = { [weak self] count, time in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.deposit) == true {
                    self.waitStatusView.waitingCustomersCountView.setData(.deposit, .waitingCustomers, String(count ?? 0))
                    self.waitStatusView.estimatedWaitTimeView.setData(.deposit, .estimatedWaitTime, String(Int(time ?? 0.0)))
                    
                    guard let count = count else { return }
                    
                    if count <= 1 && self.isWaiting {
                        self.waitStatusView.waitingAnimationView.setStyle(.animated(fillIndex: 2))
                    } else if count >= 1 && self.isWaiting && count <= 5 {
                        self.waitStatusView.waitingAnimationView.setStyle(.animated(fillIndex: 1))
                    } else if count > 5 && self.isWaiting {
                        self.waitStatusView.waitingAnimationView.setStyle(.animated(fillIndex: 0))
                    }
                    
                    if count == 0 {
                        self.isWaiting = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.waitStatusView.waitingAnimationView.setStyle(.basic)
                        }
                    }
                    
                    if !self.isWaiting {
                        self.waitStatusView.waitingAnimationView.setStyle(.basic)
                    }
                }
            }
        }

        viewModel.loanCountDidChange = { [weak self] count, time in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.loan) == true {
                    self.waitStatusView.waitingCustomersCountView.setData(.loan, .waitingCustomers, String(count ?? 0))
                    self.waitStatusView.estimatedWaitTimeView.setData(.loan, .estimatedWaitTime, String(Int(time ?? 0.0)))
                    
                    guard let count = count else { return }
                    
                    if count <= 1 && self.isWaiting {
                        self.waitStatusView.waitingAnimationView.setStyle(.animated(fillIndex: 2))
                    } else if count >= 1 && self.isWaiting && count <= 5 {
                        self.waitStatusView.waitingAnimationView.setStyle(.animated(fillIndex: 1))
                    } else if count > 5 && self.isWaiting {
                        self.waitStatusView.waitingAnimationView.setStyle(.animated(fillIndex: 0))
                    }
                    
                    if count == 0 {
                        self.isWaiting = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.waitStatusView.waitingAnimationView.setStyle(.basic)
                        }
                    }
                    
                    if !self.isWaiting {
                        self.waitStatusView.waitingAnimationView.setStyle(.basic)
                    }
                }
            }
        }
    }
    
    private func initialButtonState() {
        isWaiting = isWaiting
    }
    
    @objc
    public func waitButtonDidTap() {
        if isButtonEnabled {
            isButtonEnabled = false
            isWaiting ? presentCancelAlertPopUp() : performWaiting()
        }
    }
    
    private func presentCancelAlertPopUp() {
        
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
        isButtonEnabled = false // 버튼 비활성화
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // 클릭 간격 제한
            self.isButtonEnabled = true // 버튼 활성화
        }
        
        isWaiting = true
        showToast(message: I18N.ServiceFeature.successWaiting)
        
        if waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.loan) == true {
            viewModel.registerWait(type: .loan)
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, Date.now.currentTimeString())
        } else {
            viewModel.registerWait(type: .deposit)
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, Date.now.currentTimeString())
        }
        
        bindViewModels()
    }
    
    private func cancelWaiting() {
        isWaiting = false
        isButtonEnabled = true // 버튼을 즉시 다시 활성화
        
        if waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.loan) == true {
            viewModel.cancelWaiting(type: .loan)
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, nil)
        } else {
            viewModel.cancelWaiting(type: .deposit)
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, nil)
        }
    }
}
