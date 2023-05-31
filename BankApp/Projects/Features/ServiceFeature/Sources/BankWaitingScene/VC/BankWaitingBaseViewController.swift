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
    
    @UserDefaultWrapper<String>(key: "waitingServiceType", defaultValue: BankingServiceType.deposit.rawValue)
    private var waitingServiceType: String
    
    @UserDefaultWrapper<Bool>(key: "isActiveWaitingNotification", defaultValue: true)
    private var isActiveWaitingNotification: Bool
    
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
    private let userNotiCenter = UNUserNotificationCenter.current()
    
    private var animationStyle: WaitingAnimationStyle = .basic {
        didSet {
            waitStatusView.waitingAnimationView.setStyle(animationStyle)
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
        requestNotificationAutorization()
        setUI()
        setLayout()
        initialButtonState()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func updateAnimationStyle(count: Int?) {
        guard let count = count else { return animationStyle = .basic }
        
        if count <= 1 && isWaiting {
            animationStyle = .animated(fillIndex: 2)
        } else if count >= 1 && isWaiting && count <= 5 {
            animationStyle = .animated(fillIndex: 1)
        } else if count > 5 && isWaiting {
            animationStyle = .animated(fillIndex: 0)
        }
        
        if count == 0 {
            animationStyle = .basic
            isWaiting = false
        }
    }
}

// MARK: - Methods

extension BankWaitingBaseViewController {
    
    private func requestNotificationAutorization() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    private func requestSendNotification(seconds: Double, sceneType: BankingServiceType) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "야곰 뱅크 대기 알람"
        notiContent.body = "다음 대기 순서입니다. \(sceneType.teller) 앞에서 기다려주세요."
        notiContent.userInfo = ["targetScene": "\(sceneType.rawValue)"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (error) in
            print(#function, error as Any)
        }
    }
    
    private func removeNofiticaion() {
        userNotiCenter.removeAllDeliveredNotifications()
    }
    
    private func bindViewModels() {
        
        viewModel.depositCountDidChange = { [weak self] count, time in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.deposit) == true {
                    self.waitStatusView.waitingCustomersCountView.setData(.deposit, .waitingCustomers, String(count ?? 0))
                    self.waitStatusView.estimatedWaitTimeView.setData(.deposit, .estimatedWaitTime, String(Int(time ?? 0.0)))
                    self.updateAnimationStyle(count: count)
                }
            }
        }

        viewModel.loanCountDidChange = { [weak self] count, time in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.loan) == true {
                    self.waitStatusView.waitingCustomersCountView.setData(.loan, .waitingCustomers, String(count ?? 0))
                    self.waitStatusView.estimatedWaitTimeView.setData(.loan, .estimatedWaitTime, String(Int(time ?? 0.0)))
                    self.updateAnimationStyle(count: count)
                }
            }
        }
        self.notificationView.alertSwitch.setOn(self.isActiveWaitingNotification, animated: false)
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
        
        if waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.loan) == true {
            viewModel.registerWait(type: .loan)
            self.waitingServiceType = BankingServiceType.loan.rawValue
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, Date.now.currentTimeString())
            self.requestSendNotification(seconds: 5, sceneType: .loan) // 테스트를 위해 5초로 설정
            showToast(message: BankingServiceType.loan.teller + " " + I18N.ServiceFeature.successWaiting)
        } else {
            viewModel.registerWait(type: .deposit)
            self.waitingServiceType = BankingServiceType.deposit.rawValue
            self.waitStatusView.issuanceTimeView.setData(.deposit, .issuanceTime, Date.now.currentTimeString())
            self.requestSendNotification(seconds: 5, sceneType: .deposit) // 테스트를 위해 5초로 설정
            showToast(message: BankingServiceType.deposit.teller + " " + I18N.ServiceFeature.successWaiting)
        }
        
        bindViewModels()
    }
    
    private func cancelWaiting() {
        isWaiting = false
        isButtonEnabled = true // 버튼을 즉시 다시 활성화
        removeNofiticaion()
        
        if waitStatusView.waitingCustomersCountView.titleLabel.text?.contains(I18N.ServiceFeature.loan) == true {
            viewModel.cancelWaiting(type: .loan)
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, nil)
        } else {
            viewModel.cancelWaiting(type: .deposit)
            self.waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, nil)
        }
    }
}
