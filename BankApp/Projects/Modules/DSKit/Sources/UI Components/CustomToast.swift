//
//  CustomToast.swift
//  DSKit
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import SnapKit

public extension UIViewController {
    
    func showToast(message: String) {
        Toast.show(message: message, view: self.view)
    }
}

public class Toast {
    
    public static func show(message: String, view: UIView) {
        let toastContainer = createToastContainer()
        let toastLabel = createToastLabel(message: message)
        let toastImageView = createToastImageView()
        
        let containerStackView = createContainerStackView()
        containerStackView.addArrangedSubview(toastImageView)
        containerStackView.addArrangedSubview(toastLabel)
        toastContainer.addSubview(containerStackView)
        
        view.addSubview(toastContainer)
        
        setToastContainerLayout(toastContainer, view: view)
        setContainerStackViewLayout(containerStackView, toastContainer: toastContainer)
        setToastImageViewLayout(toastImageView)
        
        animateToast(toastContainer)
    }
}

// MARK: - UI & Layout

extension Toast {
    
    private static func createToastContainer() -> UIView {
        let toastContainer = UIView()
        toastContainer.backgroundColor = DSKitAsset.Colors.gray500.color.withAlphaComponent(0.8)
        toastContainer.alpha = 1
        toastContainer.layer.cornerRadius = 20
        toastContainer.clipsToBounds = true
        toastContainer.isUserInteractionEnabled = false
        return toastContainer
    }
    
    private static func createToastLabel(message: String) -> UILabel {
        let toastLabel = UILabel()
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 14)
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.sizeToFit()
        return toastLabel
    }
    
    private static func createToastImageView() -> UIImageView {
        let toastImageView = UIImageView()
        toastImageView.image = DSKitAsset.Images.icnLamp.image
        toastImageView.contentMode = .scaleAspectFit
        return toastImageView
    }
    
    private static func createContainerStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        return stackView
    }
    
    private static func setToastContainerLayout(_ toastContainer: UIView, view: UIView) {
        toastContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(220)
            $0.height.equalTo(44)
        }
    }
    
    private static func setContainerStackViewLayout(_ containerStackView: UIStackView, toastContainer: UIView) {
        containerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    private static func setToastImageViewLayout(_ toastImageView: UIImageView) {
        toastImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
    }
    
    private static func animateToast(_ toastContainer: UIView) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 1.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
