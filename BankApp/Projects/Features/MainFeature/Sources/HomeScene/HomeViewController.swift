//
//  HomeViewController.swift
//  MainFeature
//
//  Created by devxsby on 2023/05/21.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

public final class HomeViewController: UIViewController {
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension HomeViewController {
    
    private func setUI() {
        navigationController?.navigationBar.backgroundColor = DSKitAsset.Colors.gray100.color
        navigationController?.navigationBar.tintColor = DSKitAsset.Colors.gray300.color
        view.backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    private func setLayout() {
        
    }
}
