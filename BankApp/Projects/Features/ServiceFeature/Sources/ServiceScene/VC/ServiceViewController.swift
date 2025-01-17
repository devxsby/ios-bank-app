//
//  ServiceViewController.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/20.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit

import ServiceFeatureInterface
import BaseFeatureDependency

public final class ServiceViewController: UIViewController, ServiceViewControllable {
    
    // MARK: - Properties
    
    public let factory: ServiceFeatureViewBuildable & AlertViewBuildable
    public let viewModel: ServiceViewModel
    
    @UserDefaultWrapper<String>(key: "waitingServiceType", defaultValue: BankingServiceType.deposit.rawValue)
    private var waitingServiceType: String
    
    @UserDefaultWrapper<Bool>(key: "isWaiting", defaultValue: false)
    private var isWaiting: Bool
    
    @UserDefaultWrapper<Bool>(key: "isActiveWaitingNotification", defaultValue: true)
    private var isActiveWaitingNotification: Bool
        
    // MARK: - UI Components
    
    private lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.refreshControl = refresher
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let mobileBankingSectionView = UIView()
    
    private let mobileNumberingLabel: UILabel = {
        let label = UILabel()
        label.text = ServiceType.mobileBanking.title
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 22)
        return label
    }()
    private let searchView = BankingSearchView()
    private let bankInformationView = BankInformationContainerView()
    private let loansWaitingBoxView = TellerWaitingBoxView(type: .loan)
    private let depositsWaitingBoxView = TellerWaitingBoxView(type: .deposit)
    private let showMyWaitlistView = MyWaitlistView()
    
    private let horizontalLineView = UIView()
    
    // MARK: - Initialization
    
    public init(factory: ServiceFeatureViewBuildable & AlertViewBuildable, viewModel: ServiceViewModel) {
        self.factory = factory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        viewModel.startProcessing()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModels()
    }
}

// MARK: - UI & Layout

extension ServiceViewController {
        
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = I18N.ServiceFeature.service
        
        mobileBankingSectionView.backgroundColor = .white
        horizontalLineView.backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    private func setLayout() {
        
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(mobileBankingSectionView)
        [mobileNumberingLabel, searchView, bankInformationView,
         loansWaitingBoxView, depositsWaitingBoxView,
         showMyWaitlistView, horizontalLineView].forEach { mobileBankingSectionView.addSubview($0) }
        
        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mobileBankingSectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
//            $0.height.equalTo(1000)
        }
        
        mobileNumberingLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(mobileNumberingLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(45)
        }
        
        bankInformationView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        loansWaitingBoxView.snp.makeConstraints {
            $0.top.equalTo(bankInformationView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        
        depositsWaitingBoxView.snp.makeConstraints {
            $0.top.equalTo(loansWaitingBoxView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        
        showMyWaitlistView.snp.makeConstraints {
            $0.top.equalTo(depositsWaitingBoxView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.top.equalTo(showMyWaitlistView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(4)
        }
    }
}

// MARK: - Methods

extension ServiceViewController {
    
    private func bindViewModels() {
        
        viewModel.loanCountDidChange = { count, time in
            self.updateLoanLabel(count, time)
        }
        
        viewModel.depositCountDidChange = { count, time in
            self.updateDepositLabel(count, time)
        }
    }
    
    private func setDelegate() {
        showMyWaitlistView.delegate = self
        loansWaitingBoxView.delegate = self
        depositsWaitingBoxView.delegate = self
    }
    
    private func updateLoanLabel(_ count: Int?, _ time: Double?) {
        loansWaitingBoxView.setData(count, .loan)
    }
    
    private func updateDepositLabel(_ count: Int?, _ time: Double?) {
        depositsWaitingBoxView.setData(count, .deposit)
    }
    
    // MARK: - @objc Function
    
    @objc
    private func refreshed() {
        self.containerScrollView.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.async {
            self.containerScrollView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - MyWaitlistViewDelegate

extension ServiceViewController: MyWaitlistViewDelegate {
    
    public func didPressWaitlistView() {
        makeVibrate()
        if isWaiting && isActiveWaitingNotification == true {
            if waitingServiceType == BankingServiceType.deposit.rawValue {
                guard let detailVC = factory.makeBankWaitingViewController().viewController
                        as? BankWaitingDetailViewController else { return }
                detailVC.hidesBottomBarWhenPushed = true
                detailVC.initialTab = BankingServiceType.deposit.tabIndex
                navigationController?.pushViewController(detailVC, animated: true)
            } else {
                guard let detailVC = factory.makeBankWaitingViewController().viewController
                        as? BankWaitingDetailViewController else { return }
                detailVC.hidesBottomBarWhenPushed = true
                detailVC.initialTab = BankingServiceType.loan.tabIndex
                navigationController?.pushViewController(detailVC, animated: true)
            }
        } else {
            showToast(message: I18N.ServiceFeature.Alert.noWaitingList)
        }
    }
}

// MARK: - TellerWaitingBoxViewDelegate

extension ServiceViewController: TellerWaitingBoxViewDelegate {
    
    public func pushToDetailViewCotroller(_ type: BankingServiceType) {
        guard let detailVC = factory.makeBankWaitingViewController().viewController
                as? BankWaitingDetailViewController else { return }
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.initialTab = type.tabIndex
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
