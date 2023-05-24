//
//  BankInformationContainerView.swift
//  ServiceFeatureInterface
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit
import MapKit

import BaseFeatureDependency
import Core
import DSKit

final public class BankInformationContainerView: UIView {
    
    // MARK: - UI Components
    
    private let mapView = BankMapView()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(DSKitAsset.Images.icnFriend.image, for: .normal)
        button.addTarget(self, action: #selector(centerMapOnUserLocation), for: .touchUpInside)
        return button
    }()
    
//    private let mapImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = DSKitAsset.Images.imgSamplePlace.image
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 20
//        imageView.contentMode = .scaleToFill
//        return imageView
//    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.sampleBankName
        label.font = DSKitFontFamily.SpoqaHanSansNeo.bold.font(size: 16)
        label.textColor = .black
        return label
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.sampleBankPlace
        label.font = DSKitFontFamily.SpoqaHanSansNeo.regular.font(size: 14)
        label.textColor = .black
        return label
    }()
    
    private let businessHoursLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ServiceFeature.sampleBankBusinessHours
        label.font = DSKitFontFamily.SpoqaHanSansNeo.medium.font(size: 13)
        label.textColor = DSKitAsset.Colors.gray300.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            placeLabel,
            businessHoursLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Initialization
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layout

extension BankInformationContainerView {
    
    private func setUI() {
        backgroundColor = .white
        mapView.layer.cornerRadius = 20
    }
    
    private func setLayout() {
        
        [mapView, stackView, locationButton].forEach { self.addSubview($0) }
        
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints {
            $0.top.trailing.equalTo(mapView).inset(10)
            $0.width.height.equalTo(24)
        }
    }
}

// MARK: - Methods

extension BankInformationContainerView {
    
    @objc
    public func centerMapOnUserLocation() {
        guard let userLocation = mapView.userLocation.location else { return }
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}
