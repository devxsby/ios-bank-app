//
//  HomeViewController.swift
//  MainFeature
//
//  Created by devxsby on 2023/05/21.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import BaseFeatureDependency
import Core
import DSKit
import MainFeatureInterface

import SnapKit

public final class HomeViewController: UIViewController, HomeViewControllable {
    
    // MARK: - Properties
    
    public var viewModel: HomeViewModel
    private var cancelBag = CancelBag()
    private var sections = [HomeItem]()
    private var isFirstEntry = true
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = DSKitAsset.Colors.gray100.color
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            guard let sectionType = self?.sections[section].type else { return nil }
            
            switch sectionType {
            case .bankIntroduce:
                return self?.createBankInformationSection()
            case .point:
                return self?.createPointSection()
            case .assets:
                return self?.createAssetsSection()
            case .investments:
                return self?.createInvestmentsSection()
            case .consumption:
                return self?.createConsumptionSection()
            case .life:
                return self?.createLifeSection()
            }
        }
    }()
    
    private lazy var alarmBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: DSKitAsset.Images.icnAlarmFill.image.withRenderingMode(.alwaysOriginal),
                                        style: .plain,
                                        target: self,
                                        action: #selector(settingButtonTapped))
        return barButton
    }()
    
    private let bottomComsumptionView = AccountInformationView(type: .comsumption)
    
    // MARK: - Initialization
    
    public init(viewModel: HomeViewModel) {
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
        registerCells()
        bindViewModels()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
}

// MARK: - UI & Layout

extension HomeViewController {

    private func setUI() {
        view.backgroundColor = DSKitAsset.Colors.gray100.color
        navigationController?.navigationBar.backgroundColor = DSKitAsset.Colors.gray100.color
        navigationController?.navigationBar.tintColor = DSKitAsset.Colors.gray300.color
        navigationItem.rightBarButtonItem = alarmBarButton
        bottomComsumptionView.layer.cornerRadius = 20
        bottomComsumptionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomComsumptionView.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 3)
    }
    
    private func setLayout() {
        
        view.addSubview(collectionView)
        view.addSubview(bottomComsumptionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bottomComsumptionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.height.equalTo(70)
        }
        
        bottomComsumptionView.titleLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.centerY.equalToSuperview().multipliedBy(0.9)
        }
    }
}

// MARK: - Methods

extension HomeViewController {
    
    private func bindViewModels() {
        let input = HomeViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }
    
    private func registerCells() {
        
        collectionView.register(BankIntroduceCell.self, forCellWithReuseIdentifier: HomeItemType.bankIntroduce.reuseIdentifier)
        collectionView.register(EarnPointCell.self, forCellWithReuseIdentifier: HomeItemType.point.reuseIdentifier)
        collectionView.register(AccountInformationCell.self, forCellWithReuseIdentifier: HomeItemType.assets.reuseIdentifier)
        collectionView.register(AccountInformationCell.self, forCellWithReuseIdentifier: HomeItemType.investments.reuseIdentifier)
        collectionView.register(AccountInformationCell.self, forCellWithReuseIdentifier: HomeItemType.consumption.reuseIdentifier)
        collectionView.register(LifeTipCell.self, forCellWithReuseIdentifier: HomeItemType.life.reuseIdentifier)
        
        collectionView.register(AccountInformamtionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AccountInformamtionReusableView.className)
        collectionView.register(HomeFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeFooterView.className)
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc
    private func settingButtonTapped() {
        print("setting button did tap")
    }
}

// MARK: - Make NSCollectionLayoutSections

extension HomeViewController {
    
    private func createBankInformationSection() -> NSCollectionLayoutSection {
        return createSectionWithVerticalGroup(itemCount: 1, itemHeight: 75)
    }
    
    private func createPointSection() -> NSCollectionLayoutSection {
        return createSectionWithVerticalGroup(itemCount: 1, itemHeight: 160)
    }
    
    private func createAssetsSection() -> NSCollectionLayoutSection {
        let headerKind = UICollectionView.elementKindSectionHeader
        return createSectionWithVerticalGroup(itemCount: 5, itemHeight: 400, headerKind: headerKind)
    }
    
    private func createInvestmentsSection() -> NSCollectionLayoutSection {
        let headerKind = UICollectionView.elementKindSectionHeader
        return createSectionWithVerticalGroup(itemCount: 1, itemHeight: 80, headerKind: headerKind)
    }
    
    private func createConsumptionSection() -> NSCollectionLayoutSection {
        let headerKind = UICollectionView.elementKindSectionHeader
        return createSectionWithVerticalGroup(itemCount: 2, itemHeight: 160, headerKind: headerKind)
    }
    
    private func createLifeSection() -> NSCollectionLayoutSection {
        let footerKind = UICollectionView.elementKindSectionFooter
        return createSectionWithHorizontalGroup(itemCount: 1, itemWidth: 140, itemHeight: 160, interItemSpacing: 15, footerKind: footerKind)
    }
    
    private func createSectionWithVerticalGroup(itemCount: Int,
                                                itemHeight: CGFloat,
                                                headerKind: String? = nil) -> NSCollectionLayoutSection {
        
        let sectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 15)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(itemHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(itemHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: itemCount)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 15
        section.contentInsets = sectionInsets
        
        if let kind = headerKind {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(60))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
    
    private func createSectionWithHorizontalGroup(itemCount: Int,
                                                  itemWidth: CGFloat,
                                                  itemHeight: CGFloat,
                                                  interItemSpacing: CGFloat,
                                                  footerKind: String? = nil) -> NSCollectionLayoutSection {
        
        let sectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 15)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth),
                                              heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth * CGFloat(itemCount) + interItemSpacing * CGFloat(itemCount - 1)),
                                               heightDimension: .absolute(itemHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemCount)
        group.interItemSpacing = .fixed(interItemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 15
        section.contentInsets = sectionInsets
        
        if let kind = footerKind {
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(160))
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: kind, alignment: .bottom)
            section.boundarySupplementaryItems = [footer]
        }
        
        return section
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        makeVibrate(degree: .light)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        return section.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section].type
        let reuseIdentifier: String
        
        switch sectionType {
        case .bankIntroduce:
            reuseIdentifier = HomeItemType.bankIntroduce.reuseIdentifier
        case .point:
            reuseIdentifier = HomeItemType.point.reuseIdentifier
        case .assets:
            reuseIdentifier = HomeItemType.assets.reuseIdentifier
        case .investments:
            reuseIdentifier = HomeItemType.investments.reuseIdentifier
        case .consumption:
            reuseIdentifier = HomeItemType.consumption.reuseIdentifier
        case .life:
            reuseIdentifier = HomeItemType.life.reuseIdentifier
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        switch sectionType {
        case .bankIntroduce:
            if let item = sections[indexPath.section].items[indexPath.row] as? BankIntroduceModel {
                (cell as? BankIntroduceCell)?.setData(item)
            }
        case .point:
            if let item = sections[indexPath.section].items[indexPath.row] as? EarnPointModel {
                (cell as? EarnPointCell)?.setData(item)
            }
        case .assets, .investments, .consumption:
            if let item = sections[indexPath.section].items[indexPath.row] as? AccountInformationModel {
                (cell as? AccountInformationCell)?.setData(item)
            }
        case .life:
            if let item = sections[indexPath.section].items[indexPath.row] as? LifeTipModel {
                (cell as? LifeTipCell)?.setData(item)
            }
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AccountInformamtionReusableView.className, for: indexPath) as? AccountInformamtionReusableView else {
                return UICollectionReusableView()
            }
//            headerView.backgroundColor = .white
            let item = sections[indexPath.section]
            headerView.setData(item.headerText)
//            print(headerView.frame.origin.y)
            return headerView
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeFooterView.className, for: indexPath) as? HomeFooterView else {
                return UICollectionReusableView()
            }
            return footerView
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    // TODO: - 애니메이션 추가
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let itemLowerHeight = 280 - bottomComsumptionView.frame.height + SafeAreaHeight.safeAreaBottomInset()
        let itemHigherHeight = 500 - bottomComsumptionView.frame.height + SafeAreaHeight.safeAreaBottomInset()
        let bottomOffset = collectionView.contentSize.height - collectionView.contentOffset.y - collectionView.bounds.height
                
        if isFirstEntry {
            isFirstEntry = false
            return
        }
        
        if bottomOffset <= itemHigherHeight {
//            print("Reached the offset: \(bottomOffset)")
        } else {
//            print("Reached Out. the offset: \(bottomOffset)")
        }
    }
}

// MARK: - Dummy 모델

struct HomeItem {
    var type: HomeItemType
    var items: [Any]
    var headerText: String?
}

extension HomeViewController {
    private func setData() {
        sections = [
            HomeItem(
                type: .bankIntroduce,
                items: [BankIntroduceModel(name: "야곰뱅크")]),
            HomeItem(
                type: .point,
                items: [EarnPointModel(title: "함께 어플 켜고 포인트 받기")]),
            HomeItem(
                type: .assets,
                items: [AccountInformationModel(image: DSKitAsset.Images.icnYagom.image,
                                                title: "야곰뱅크 주거래 통장",
                                                subtitle: "6,083,000원",
                                                buttonTitle: "송금"),
                        AccountInformationModel(image: DSKitAsset.Images.icnSaving.image,
                                                        title: "모으기 통장",
                                                        subtitle: "851,500원",
                                                        buttonTitle: nil),
                        AccountInformationModel(image: DSKitAsset.Images.icnKb.image,
                                                        title: "KB 국민은행 통장",
                                                        subtitle: "2,000원",
                                                        buttonTitle: "송금"),
                        AccountInformationModel(image: DSKitAsset.Images.icnBanks.image,
                                                        title: "증권 · 3개",
                                                        subtitle: "2,557,000원",
                                                        buttonTitle: "송금"),
                        AccountInformationModel(image: DSKitAsset.Images.icnMoneybag.image,
                                                        title: "대출 · 39개 금융사 대기중",
                                                        subtitle: "내 최대 대출 한도 보기",
                                                        buttonTitle: nil)],
                headerText: "자산"),
            HomeItem(
                type: .investments,
                items: [AccountInformationModel(image: DSKitAsset.Images.icnStocks.image,
                                                title: "주식",
                                                subtitle: "1,805,456원 + 123.6%",
                                                buttonTitle: nil)],
                headerText: "투자"),
            HomeItem(
                type: .consumption,
                items: [AccountInformationModel(image: DSKitAsset.Images.icnCards.image,
                                                title: "이번 달 쓴 금액",
                                                subtitle: "1,248,200원",
                                                buttonTitle: "내역"),
                        AccountInformationModel(image: DSKitAsset.Images.icnDday.image,
                                                        title: "6월 15일 낼 카드값",
                                                        subtitle: "913,560원",
                                                        buttonTitle: nil)],
                headerText: "소비"),
            HomeItem(
                type: .life,
                items: [LifeTipModel(title: "돈 버는 법",
                                     subtitle: "매일 포인트\n받기",
                                     image: DSKitAsset.Images.icnPoint.image),
                        LifeTipModel(title: "최근",
                                     subtitle: "오늘의\n머니 팁",
                                     image: DSKitAsset.Images.icnLamp.image),
                        LifeTipModel(title: "자주",
                                     subtitle: "신용점수\n보기",
                                     image: nil)]
            )
        ]
    }
}
