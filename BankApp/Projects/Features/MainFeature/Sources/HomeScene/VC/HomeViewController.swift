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

// TODO: - life 그룹 추가, 중복되는 코드 리팩토링

public final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var sections = [HomeItem]()
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
//            case .life:
//                return self?.createLifeSection()
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
    
    // MARK: - View Life Cycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        registerCells()
        setData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - UI & Layout

extension HomeViewController {

    private func setUI() {
        navigationController?.navigationBar.backgroundColor = DSKitAsset.Colors.gray100.color
        navigationController?.navigationBar.tintColor = DSKitAsset.Colors.gray300.color
        navigationItem.rightBarButtonItem = alarmBarButton
    }
    
    private func setLayout() {
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension HomeViewController {
    
    private func registerCells() {
        
        //cell
        collectionView.register(BankIntroduceCell.self, forCellWithReuseIdentifier: BankIntroduceCell.className)
        collectionView.register(EarnPointCell.self, forCellWithReuseIdentifier: EarnPointCell.className)
        collectionView.register(AccountInformationCell.self, forCellWithReuseIdentifier: "AssetsCell")
        collectionView.register(AccountInformationCell.self, forCellWithReuseIdentifier: "InvestmentsCell")
        collectionView.register(AccountInformationCell.self, forCellWithReuseIdentifier: "ConsumptionCell")
        
        //header
        collectionView.register(AccountInformationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AccountInformationHeaderView.className)
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
        let sectionMargin: CGFloat = 10
        let groupMargin: CGFloat = 6
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(view.frame.width - (sectionMargin * 2)),
            heightDimension: .estimated(75)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 0, leading: groupMargin, bottom: 0, trailing: groupMargin)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: sectionMargin + groupMargin, leading: sectionMargin, bottom: sectionMargin + groupMargin, trailing: sectionMargin)
        
        return section
    }
    
    
    private func createPointSection() -> NSCollectionLayoutSection {
        let sectionMargin: CGFloat = 10
        let groupMargin: CGFloat = 6
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(view.frame.width - (sectionMargin * 2)),
            heightDimension: .estimated(160)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: sectionMargin + groupMargin, leading: sectionMargin, bottom: sectionMargin + groupMargin, trailing: sectionMargin)
        
        return section
    }
        
    
    private func createAssetsSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.size.width - 30), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 15, bottom: 15, trailing: 15)

        let sectionHeader = self.createDefaultSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    private func createInvestmentsSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.size.width - 30), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 15, bottom: 15, trailing: 15)

        let sectionHeader = self.createDefaultSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    private func createConsumptionSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.size.width - 30), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        group.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 15, bottom: 15, trailing: 15)

        let sectionHeader = self.createDefaultSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
//    private func createLifeSection() -> NSCollectionLayoutSection {
//
//    }
    
    private func createDefaultSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
     }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 클릭")
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
        switch sectionType {
        case .bankIntroduce:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankIntroduceCell.className, for: indexPath) as? BankIntroduceCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? BankIntroduceModel else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            cell.setData(item)
            return cell
        case .point:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EarnPointCell.className, for: indexPath) as? EarnPointCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? EarnPointModel else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            cell.setData(item)
            return cell
        case .assets:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetsCell", for: indexPath) as? AccountInformationCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? AccountInformationModel else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            cell.setData(item)
            return cell
        case .investments:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvestmentsCell", for: indexPath) as? AccountInformationCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? AccountInformationModel else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            cell.setData(item)
            return cell
        case .consumption:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConsumptionCell", for: indexPath) as? AccountInformationCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? AccountInformationModel else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            cell.setData(item)
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AccountInformationHeaderView.className, for: indexPath) as? AccountInformationHeaderView else {
                return UICollectionReusableView()
            }
            headerView.backgroundColor = .white
            let item = sections[indexPath.section]
            headerView.setData(item.headerText)
            return headerView
        }
        return UICollectionReusableView()
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
                                                title: "야곰 뱅크 통장",
                                                subtitle: "123,456,789 원",
                                                buttonTitle: "송금"),
                        AccountInformationModel(image: DSKitAsset.Images.icnSaving.image,
                                                        title: "야곰뱅크 통장",
                                                        subtitle: "123,456원",
                                                        buttonTitle: nil),
                        AccountInformationModel(image: DSKitAsset.Images.icnKb.image,
                                                        title: "KB 국민은행 통장",
                                                        subtitle: "2,000원",
                                                        buttonTitle: "송금"),
                        AccountInformationModel(image: DSKitAsset.Images.icnBanks.image,
                                                        title: "증권 · 3개",
                                                        subtitle: "457,000원",
                                                        buttonTitle: "송금"),
                        AccountInformationModel(image: DSKitAsset.Images.icnMoneybag.image,
                                                        title: "대출 · 59개 금융사 대기중",
                                                        subtitle: "내 최대 대출 한도 보기",
                                                        buttonTitle: nil)],
                headerText: "자산"),
            HomeItem(
                type: .investments,
                items: [AccountInformationModel(image: DSKitAsset.Images.icnBanks.image,
                                                title: "주식",
                                                subtitle: "123,456원 + 123.6%",
                                                buttonTitle: nil)],
                headerText: "투자"),
            HomeItem(
                type: .consumption,
                items: [AccountInformationModel(image: DSKitAsset.Images.icnCards.image,
                                                title: "이번 달 쓴 금액",
                                                subtitle: "123,456,789원",
                                                buttonTitle: "내역"),
                        AccountInformationModel(image: DSKitAsset.Images.icnDday.image,
                                                        title: "6월 15일 낼 카드값",
                                                        subtitle: "123,456원",
                                                        buttonTitle: nil)],
                headerText: "소비"
            )
        ]
    }
}
