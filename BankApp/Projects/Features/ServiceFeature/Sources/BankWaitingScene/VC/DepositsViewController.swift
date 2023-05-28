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
        print("예금 뷰")
        updateView()
    }
}

// MARK: - Methods

extension DepositsViewController {
    
    func updateView() {
        // TODO: 예금과 대출의 버튼 상태가 하나로 같이 가야하나? 독립적으로 가야하나?
        waitStatusView.loadingView(isActivate: true)
        
        let customers = String(WaitingInfoManager.shared.depositCount)
        let time = String(Int(WaitingInfoManager.shared.depositTime))
        
        waitStatusView.waitingCustomersStatusView.setData(.deposit, .waitingCustomers, customers)
        waitStatusView.estimatedWaitTimeStatusView.setData(.deposit, .estimatedWaitTime, time)
        waitStatusView.issuanceTimeStatusView.setData(.deposit, .issuanceTime, nil) // TODO:  date formatrer
    }
    
    private func addButtonAction() {
        let waitButton = self.waitButton
        waitButton.addTarget(self, action: #selector(waitButtonDidTap), for: .touchUpInside)
    }
}
