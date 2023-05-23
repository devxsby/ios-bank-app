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

public final class NumberingDetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var viewTypes: [String] = [I18N.ServiceFeature.loans, I18N.ServiceFeature.deposits]
    
    // MARK: - Properties
    
    private let loanDetailVC = LoansViewController()
    private let depositDetailVC = DepositsViewController()
    
    public lazy var detailViewControllers: [UIViewController] = {
        return [loanDetailVC, depositDetailVC]
    }()
    
    private var currentPage: Int = 0 {
        didSet {
            bind(newValue: currentPage)
        }
    }
    
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

extension NumberingDetailViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        title = I18N.ServiceFeature.mobileNumbering
        navigationItem.largeTitleDisplayMode = .never
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

extension NumberingDetailViewController {
    
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
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        headerCollectionView.selectItem(at: selectedIndexPath,
                                        animated: true,
                                        scrollPosition: .bottom)
        
        if let loansVC = detailViewControllers.first {
            pageViewController.setViewControllers(
                [loansVC],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension NumberingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension NumberingDetailViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(viewTypes.count)
        return CGSize(width: width - 5, height: 40)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension NumberingDetailViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = detailViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        return detailViewControllers[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = detailViewControllers.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = detailViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == detailViewControllers.count { return nil }
        return detailViewControllers[nextIndex]
    }
}
