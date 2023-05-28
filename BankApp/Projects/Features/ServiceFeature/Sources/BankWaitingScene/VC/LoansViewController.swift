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
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addButtonAction()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("대출 뷰")
        updateView()
    }
}

// MARK: - Methods

extension LoansViewController {
    
    func updateView() {
        // TODO: 예금과 대출의 버튼 상태가 하나로 같이 가야하나? 독립적으로 가야하나?
        waitStatusView.loadingView(isActivate: true)
        
        let customers = String(WaitingInfoManager.shared.loanCount)
        let time = String(Int(WaitingInfoManager.shared.loanTime))
        
        waitStatusView.waitingCustomersStatusView.setData(.deposit, .waitingCustomers, customers)
        waitStatusView.estimatedWaitTimeStatusView.setData(.deposit, .estimatedWaitTime, time)
        waitStatusView.issuanceTimeStatusView.setData(.loan, .issuanceTime, nil)
    }
    
    private func addButtonAction() {
        let waitButton = self.waitButton
        waitButton.addTarget(self, action: #selector(waitButtonDidTap), for: .touchUpInside)
    }
}
