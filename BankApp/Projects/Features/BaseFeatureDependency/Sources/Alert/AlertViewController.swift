//
//  AlertViewController.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/23.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public final class AlertViewController: UIViewController {
    
    // MARK: - Properties
    
    public var customAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var backgroundDimmerView = CustomDimmerView(self) {
            didSet {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDimmerViewTapped))
                gesture.cancelsTouchesInView = false
                backgroundDimmerView.addGestureRecognizer(gesture)
            }
        }
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let cancelButton = UIButton()
    private var customButton = UIButton()
    private var alertType: AlertType
    
    // MARK: - Initialization
    
    public init(alertType: AlertType) {
        self.alertType = alertType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycles
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout(alertType)
        setAddTarget()
    }
}

// MARK: - Methods

extension AlertViewController {
    
    @discardableResult
    public func setTitle(_ title: String) -> Self {
        self.titleLabel.text = title
        return self
    }
    
    @discardableResult
    public func setCustomButtonTitle(_ title: String) -> Self {
        self.customButton.setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    func setCustomButtonAction(_ closure: (() -> Void)? = nil) -> Self {
        self.customAction = closure
        return self
    }
    
    private func setAddTarget() {
        self.cancelButton.addTarget(self, action: #selector(dismissCurrentVC), for: .touchUpInside)
        self.customButton.addTarget(self, action: #selector(tappedCustomButton), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissCurrentVC))
        self.backgroundDimmerView.addGestureRecognizer(gesture)
    }
    
    // MARK: - @objc Function
    
    @objc
    private func dismissCurrentVC() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func tappedCustomButton() {
        self.dismiss(animated: true) {
            self.customAction?()
        }
    }
    
    @objc private func backgroundDimmerViewTapped() {
        // 팝업 외부 영역을 터치했을 때 아무 동작도 하지 않도록 빈 함수로 구현
    }
}

// MARK: - UI & Layout

extension AlertViewController {
    
    private func setUI() {
        self.view.backgroundColor = .clear
        self.alertView.backgroundColor = .white
        self.cancelButton.backgroundColor = DSKitAsset.Colors.gray200.color
        self.customButton.backgroundColor = DSKitAsset.Colors.blue.color
        
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        self.titleLabel.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 15)
        self.cancelButton.titleLabel?.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 12)
        self.customButton.titleLabel?.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 12)
        
        self.titleLabel.textColor = .black
        self.cancelButton.setTitleColor(.black, for: .normal)
        self.customButton.setTitleColor(.white, for: .normal)

        let cancelTitle = (self.alertType == .networkErr) ? I18N.Alert.reload : I18N.ServiceFeature.Alert.no
        self.cancelButton.setTitle(cancelTitle, for: .normal)
        
        self.alertView.layer.cornerRadius = 10
        self.alertView.layer.masksToBounds = true
        
        self.cancelButton.layer.cornerRadius = 10
        self.customButton.layer.cornerRadius = 10
    }
    
    private func setLayout(_ type: AlertType) {
        
        [backgroundDimmerView, alertView].forEach { view.addSubview($0) }
        alertView.addSubview(titleLabel)
        
        backgroundDimmerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(alertView.snp.width).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }
        
        self.setButtonLayout(type)
    }
    
    private func setButtonLayout(_ type: AlertType) {
        alertView.addSubview(cancelButton)
        
        switch type {
        case .cancelWaiting:
            alertView.addSubview(customButton)
            
            cancelButton.snp.makeConstraints {
                $0.leading.bottom.equalToSuperview().inset(10)
                $0.width.equalTo(customButton.snp.width)
                $0.height.equalTo(40)
            }
            
            customButton.snp.makeConstraints {
                $0.trailing.bottom.equalToSuperview().inset(10)
                $0.leading.equalTo(cancelButton.snp.trailing).offset(10)
                $0.height.equalTo(cancelButton.snp.height)
            }
        case .networkErr:
            cancelButton.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview().inset(10)
                $0.height.equalTo(40)
            }
        }
    }
}
