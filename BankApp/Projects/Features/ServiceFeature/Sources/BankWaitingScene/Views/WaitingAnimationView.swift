//
//  WaitingAnimationView.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/29.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public final class WaitingAnimationView: UIView {
    
    // MARK: - UI Components
    
    private let frontImageView = UIImageView()
    
    // MARK: - Properties
    
    private var jumpingViews = [UIImageView]()
    private var isJumpingAnimationEnabled = false
    
    // MARK: - Initialization
    
    public init(_ style: WaitingAnimationStyle = .basic) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setStyle(.basic)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension WaitingAnimationView {
    
    private func setUI() {
        backgroundColor = .clear
        frontImageView.image = DSKitAsset.Images.imgDesk.image
    }
    
    private func setLayout() {
        
        addSubview(frontImageView)
        
        for _ in 0..<3 {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 115))
            imageView.image = DSKitAsset.Images.imgPeopleUnfill.image
            jumpingViews.append(imageView)
            self.addSubview(imageView)
        }
        
        frontImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(120)
            $0.height.equalTo(135)
        }
        
        jumpingViews[0].snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        jumpingViews[1].snp.makeConstraints {
            $0.leading.equalTo(jumpingViews[0].snp.trailing).offset(10)
            $0.bottom.equalTo(jumpingViews[0]).inset(15)
        }
        
        jumpingViews[2].snp.makeConstraints {
            $0.leading.equalTo(jumpingViews[1].snp.trailing).offset(10)
            $0.bottom.equalTo(jumpingViews[1]).inset(15)
        }
    }
    
    func setStyle(_ style: WaitingAnimationStyle) {
        
        switch style {
        case .basic:
            for imageView in jumpingViews {
                imageView.image = DSKitAsset.Images.imgPeopleUnfill.image
            }
            stopJumpAnimation()
        case .animated(let fillIndex):
            for (index, imageView) in jumpingViews.enumerated() {
                if index == fillIndex {
                    imageView.image = DSKitAsset.Images.imgPeopleFill.image
                } else {
                    imageView.image = DSKitAsset.Images.imgPeopleUnfill.image
                }
            }
            startJumpAnimation()
        }
    }
}

// MARK: - Animation Methods

extension WaitingAnimationView {
    
    private func toggleJumpingAnimation() {
        if isJumpingAnimationEnabled {
            stopJumpAnimation()
        } else {
            startJumpAnimation()
        }
    }
    
    private func startJumpAnimation() {
        guard !isJumpingAnimationEnabled else { return }
        
        isJumpingAnimationEnabled = true
        
        jumpAnimation(index: 0)
    }
    
    private func stopJumpAnimation() {
        guard isJumpingAnimationEnabled else { return }
        
        isJumpingAnimationEnabled = false
        
        for imageView in jumpingViews {
            UIView.animate(withDuration: 0.5) {
                imageView.transform = .identity
            }
        }
    }
    
    private func jumpAnimation(index: Int) {
        guard isJumpingAnimationEnabled else { return }
        guard index >= 0 && index < jumpingViews.count else {
            jumpAnimation(index: 0) // 점프 애니메이션 반복
            return
        }
        
        let imageView = jumpingViews[index]
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            imageView.transform = CGAffineTransform(translationX: 0, y: -30)
                .concatenating(CGAffineTransform(scaleX: 0.93, y: 1.07))
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                imageView.transform = .identity
            }) { _ in
                self.jumpAnimation(index: index + 1) // 다음 이미지로 점프 애니메이션 진행
            }
        }
    }
}
