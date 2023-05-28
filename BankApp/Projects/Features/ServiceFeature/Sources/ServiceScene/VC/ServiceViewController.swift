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
    
    public var factory: ServiceFeatureViewBuildable & AlertViewBuildable
    public var viewModel: ServiceViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    
    private lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.refreshControl = refresher
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
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModels()
        viewModel.startProcessing()
        setData()
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
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(4)
        }
    }
}

// MARK: - Methods

extension ServiceViewController {
    
    private func bindViewModels() {
        let input = ServiceViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        // 대출 고객 수 업데이트 시 호출될 클로저
        viewModel.loanCountDidChange = { count, time in
            self.updateLoanLabel(count, time)
        }
        
        // 예금 고객 수 업데이트 시 호출될 클로저
        viewModel.depositCountDidChange = { count, time in
            self.updateDepositLabel(count, time)
        }
        
    }
    
    private func setDelegate() {
        showMyWaitlistView.delegate = self
        loansWaitingBoxView.delegate = self
        depositsWaitingBoxView.delegate = self
    }
    
    private func setData() {
        loansWaitingBoxView.setData(0, .loan)
        depositsWaitingBoxView.setData(0, .deposit)
    }
    
    // 대출 라벨 업데이트
    private func updateLoanLabel(_ count: Int, _ time: Double) {
        // 대출 라벨 업데이트 로직
        print("남은 대출 고객 수: \(count), 예상 대기 시간: \(time)")
    }
    
    // 예금 라벨 업데이트
    private func updateDepositLabel(_ count: Int, _ time: Double) {
        // 예금 라벨 업데이트 로직
        print("남은 예금 고객 수: \(count), 예상 대기 시간: \(time)")
    }
    
    // MARK: - @objc Function
    
    @objc
    private func refreshed() {
        print("refreshed")
        self.containerScrollView.refreshControl?.endRefreshing()
    }
}

// MARK: - MyWaitlistViewDelegate

extension ServiceViewController: MyWaitlistViewDelegate {
    
    public func didPressWaitlistView() {
        // TODO: 분기처리를 해야하는데 isWaiting상태를 어떻게 공유하면 좋을까?
        showToast(message: I18N.ServiceFeature.Alert.noWaitingList)
        makeVibrate()
//        let detailVC = factory.makeBankWaitingViewController().viewController
//        detailVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(detailVC, animated: true)
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
