//
//  LoansDetailViewController.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import Domain

public final class LoansViewController: BankWaitingBaseViewController {
    
    // MARK: - Properties
    
    var currentWaitingCustomerCount: Int = 0
    var currentWaitingTime: Double = 0
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addButtonAction()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
}

// MARK: - Methods

extension LoansViewController {
    
    func updateView() {
        waitStatusView.loadingView(isActivate: true)
        isWaiting = isWaiting
        
        let customers = String(WaitingInfoManager.shared.loanCount)
        let time = String(Int(WaitingInfoManager.shared.loanTime))
        
        waitStatusView.waitingCustomersCountView.setData(.loan, .waitingCustomers, customers)
        waitStatusView.estimatedWaitTimeView.setData(.loan, .estimatedWaitTime, time)
        waitStatusView.issuanceTimeView.setData(.loan, .issuanceTime, nil)
    }
    
    private func addButtonAction() {
        let waitButton = self.waitButton
        waitButton.addTarget(self, action: #selector(waitButtonDidTap), for: .touchUpInside)
    }
}
