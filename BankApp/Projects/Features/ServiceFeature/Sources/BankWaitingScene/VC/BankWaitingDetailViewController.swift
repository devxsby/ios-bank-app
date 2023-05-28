//
//  MobileNumberingDetailViewController.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

import Core
import DSKit
import ServiceFeatureInterface
import BaseFeatureDependency

public final class BankWaitingDetailViewController: UIViewController, ServiceViewControllable {
    
    // MARK: - Properties
    
    public var factory: AlertViewBuildable
    
    public var initialTab: Int = 0
    private var viewTypes: [String] = [I18N.ServiceFeature.loan, I18N.ServiceFeature.deposit]
    private var currentPage: Int = 0 {
        didSet {
            bind(newValue: currentPage)
        }
    }
    
    // MARK: - UI Components
    
    private lazy var loanDetailVC = LoansViewController(factory: factory)
    private lazy var depositDetailVC = DepositsViewController(factory: factory)
    
    private lazy var backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: DSKitAsset.Images.icnBackArrow.image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(dismissVC))
        return barButton
    }()
    
    private lazy var refreshBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: DSKitAsset.Images.refresh.image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(refreshed))
        barButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshed)))
        return barButton
    }()
    
    public lazy var detailViewControllers: [UIViewController] = {
        return [loanDetailVC, depositDetailVC]
    }()
    
    // MARK: - UI Components
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    private let pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageViewController
    }()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = DSKitAsset.Colors.gray300.color.withAlphaComponent(0.5)
        return view
    }()
    
    // MARK: - Initialization
    
    public init(factory: AlertViewBuildable) {
        self.factory = factory
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
        registerCells()
        setDelegate()
        setFirstIndexSelected()
    }
}

// MARK: - UI & Layout

extension BankWaitingDetailViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        title = I18N.ServiceFeature.mobileNumbering
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = refreshBarButton
        headerCollectionView.backgroundColor = .clear
    }
    
    private func setLayout() {
        [headerCollectionView, pageViewController.view, horizontalView].forEach { view.addSubview($0) }
        
        headerCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(63)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(headerCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        horizontalView.snp.makeConstraints {
            $0.bottom.equalTo(headerCollectionView.snp.bottom).offset(-11)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

// MARK: - Methods

extension BankWaitingDetailViewController {
    
    private func registerCells() {
        headerCollectionView.register(
            MobileNumberingTypeCell.self,
            forCellWithReuseIdentifier: MobileNumberingTypeCell.className
        )
    }
    
    private func setDelegate() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
    
    }
    
    private func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }
    
    private func bind(newValue: Int) {
        headerCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0),
                                        animated: true,
                                        scrollPosition: .centeredHorizontally)
    }
    
    private func setFirstIndexSelected() {
        let selectedIndexPath = IndexPath(item: initialTab, section: 0)
        headerCollectionView.selectItem(at: selectedIndexPath,
                                        animated: true,
                                        scrollPosition: .bottom)
        pageViewController.setViewControllers([detailViewControllers[initialTab]], direction: .forward, animated: true, completion: nil)
        
    }
    
    // MARK: - @objc Function
    
    @objc
    private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func refreshed() {
        print("새로고침 버튼 클릭 !!!")
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension BankWaitingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewTypes.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MobileNumberingTypeCell.className, for: indexPath) as? MobileNumberingTypeCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(menuLabel: viewTypes[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pageViewController.setViewControllers([detailViewControllers[indexPath.item]], direction: indexPath.row == 0 ? .reverse : .forward, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BankWaitingDetailViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(viewTypes.count)
        return CGSize(width: width - 5, height: 40)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension BankWaitingDetailViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let index = detailViewControllers.firstIndex(of: viewController) else { return nil }
//        let previousIndex = index - 1
//        if previousIndex < 0 { return nil }
//        return detailViewControllers[previousIndex]
    return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = detailViewControllers.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let index = detailViewControllers.firstIndex(of: viewController) else { return nil }
//        let nextIndex = index + 1
//        if nextIndex == detailViewControllers.count { return nil }
//        return detailViewControllers[nextIndex]
        return nil
    }
}
