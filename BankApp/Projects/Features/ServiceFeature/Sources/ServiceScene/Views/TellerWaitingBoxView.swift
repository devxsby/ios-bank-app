//
//  TellerWaitingBoxView.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public protocol TellerWaitingBoxViewDelegate: AnyObject {
    func pushToDetailViewCotroller(_ type: BankingServiceType)
}

final public class TellerWaitingBoxView: UIView {
    
    // MARK: - Properties

    weak var delegate: TellerWaitingBoxViewDelegate?
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 15)
        label.textColor = DSKitAsset.Colors.gray600.color
        return label
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.tintColor = DSKitAsset.Colors.gray300.color
        var titleAttr = AttributedString(.init(I18N.ServiceFeature.showDetail))
        titleAttr.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 15)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = titleAttr
        config.baseBackgroundColor = .black
        config.image = DSKitAsset.Images.icnNext.image
        config.imagePlacement = .trailing
        button.configuration = config
        button.isUserInteractionEnabled = false
        return button
    }()
    
    // MARK: - Initialization
    
    public init(type: BankingServiceType, _ peopleCount: Int = 0) {
        super.init(frame: .zero)
        setUI(type)
        setLayout(type)
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension TellerWaitingBoxView {
    
    private func setUI(_ type: BankingServiceType) {
        containerView.backgroundColor = DSKitAsset.Colors.gray100.color
        containerView.layer.cornerRadius = 20
        titleLabel.text = "\(type.teller) - \(I18N.ServiceFeature.peopleCount)"
    }
    
    private func setLayout(_ type: BankingServiceType) {
        
        addSubview(containerView)
        [titleLabel, detailButton].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        detailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension TellerWaitingBoxView {
    
    private func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.delaysTouchesEnded = false
        tapGestureRecognizer.delaysTouchesBegan = false
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public func setData(_ peopleCount: Int = 0, _ type: BankingServiceType) {
        let peopleCountString = String(peopleCount)
        DispatchQueue.main.async {
            self.titleLabel.text = "\(type.teller) \(peopleCount) \(I18N.ServiceFeature.peopleCount)"
            
            var textColor: UIColor
            if peopleCount == 0 {
                textColor = DSKitAsset.Colors.gray500.color
            } else if peopleCount >= 10 {
                textColor = DSKitAsset.Colors.warning.color
            } else {
                textColor = DSKitAsset.Colors.blue.color
            }
            self.titleLabel.partColorChange(targetString: peopleCountString, textColor: textColor)
        }
    }
    
    // MARK: - @objc Function
    
    @objc
    private func handleTap() {
        
        containerView.backgroundColor = DSKitAsset.Colors.gray300.color.withAlphaComponent(0.15)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.containerView.backgroundColor = DSKitAsset.Colors.gray100.color
            
            if (self.titleLabel.text?.contains(I18N.ServiceFeature.deposit)) == true {
                self.delegate?.pushToDetailViewCotroller(.deposit)
            } else {
                self.delegate?.pushToDetailViewCotroller(.loan)
            }
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension TellerWaitingBoxView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
