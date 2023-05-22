//
//  ServiceViewController.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/20.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import DSKit

import SnapKit

enum ServiceType: String {
    case mobileNumbering
}

public class ServiceViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - @objc Function
    
    @objc
    private func settingBarButtonDidTap() {
        print("설정 버튼 클릭")
    }
}

// MARK: - UI & Layout

extension ServiceViewController {
    
    // MARK: - Methods
    
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        title = "서비스"
        
        contentView.backgroundColor = .white
    }
    
    private func setLayout() {
        
        [containerScrollView].forEach { view.addSubview($0) }
        containerScrollView.addSubview(contentView)

        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
    }
}
