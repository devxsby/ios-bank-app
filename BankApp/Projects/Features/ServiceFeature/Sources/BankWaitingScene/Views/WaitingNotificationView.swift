//
//  WaitingNotificationView.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public protocol WaitingNotificationViewDelegate: AnyObject {
    func toggleSwitch(_ isOn: Bool)
}

final public class WaitingNotificationView: UIView {
    
    // MARK: - Properties
    
    public weak var delegate: WaitingNotificationViewDelegate?
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.waitingNotifications
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 16)
        label.textColor = DSKitAsset.Colors.gray600.color
        return label
    }()
    
    lazy var alertSwitch: UISwitch = {
        let alertSwitch = UISwitch()
        alertSwitch.onTintColor = DSKitAsset.Colors.blue.color
        alertSwitch.setOn(true, animated: false)
        alertSwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        return alertSwitch
    }()
        
    private let singleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
      }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
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

extension WaitingNotificationView {
    
    private func setUI() {
        backgroundColor = .white
    }
    
    private func setLayout() {
        [titleLabel, alertSwitch, containerStackView].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(5)
        }
        
        alertSwitch.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        joinStackViews()
    }
    
    private func addSingleStackView(_ subtitle: String) {
        
        let dotLabel: UILabel = {
            let label = UILabel()
            label.textColor = DSKitAsset.Colors.gray400.color
            label.text = I18N.ServiceFeature.dot
            return label
        }()
        
        let subtitleLabel: UILabel = {
            let label = UILabel()
            label.text = subtitle
            label.lineBreakMode = .byCharWrapping
            label.textColor = DSKitAsset.Colors.gray400.color
            label.font = DSKitFontFamily.SpoqaHanSansNeo.regular.font(size: 14)
            label.numberOfLines = 0
            label.setLineSpacing(lineSpacing: 5)
            return label
        }()
        
        let singleStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .leading
            stackView.spacing = 5
            return stackView
        }()
        
        singleStackView.addArrangedSubview(dotLabel)
        singleStackView.addArrangedSubview(subtitleLabel)
        containerStackView.addArrangedSubview(singleStackView)
    }
    
    private func joinStackViews() {
        addSingleStackView(I18N.ServiceFeature.waitingNotification1)
        addSingleStackView(I18N.ServiceFeature.waitingNotification2)
        addSingleStackView(I18N.ServiceFeature.waitingNotification3)
    }
}

// MARK: - Methods

extension WaitingNotificationView {
        
    @objc
    private func switchStateDidChange(_ sender: UISwitch) {
        delegate?.toggleSwitch(sender.isOn)
    }
}
