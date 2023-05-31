//
//  DepositsDetailViewController.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import Domain

public final class DepositsViewController: BankWaitingBaseViewController {
    
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

extension DepositsViewController {
    
    func updateView() {
        waitStatusView.loadingView(isActivate: true)
        isWaiting = isWaiting
        
        let customers = String(WaitingInfoManager.shared.depositCount)
        let time = String(Int(WaitingInfoManager.shared.depositTime))
        
        waitStatusView.waitingCustomersCountView.setData(.deposit, .waitingCustomers, customers)
        waitStatusView.estimatedWaitTimeView.setData(.deposit, .estimatedWaitTime, time)
        waitStatusView.issuanceTimeView.setData(.deposit, .issuanceTime, nil) // TODO:  date formatrer
    }
    
    private func addButtonAction() {
        let waitButton = self.waitButton
        waitButton.addTarget(self, action: #selector(waitButtonDidTap), for: .touchUpInside)
    }
}
