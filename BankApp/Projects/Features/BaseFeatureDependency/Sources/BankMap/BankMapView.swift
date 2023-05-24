//
//  BankMapView.swift
//  BaseFeatureDependency
//
//  Created by devxsby on 2023/05/24.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit
import MapKit

import Core
import DSKit

import SnapKit

public final class BankMapView: MKMapView {
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
        setupLocationManager()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMapView()
        setupLocationManager()
    }
    
}

// MARK: - Methods

extension BankMapView {
    
    private func setupMapView() {
        self.delegate = self
        self.showsUserLocation = true
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension BankMapView: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        addAnnotation(annotation)
        
        locationManager.stopUpdatingLocation()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - MKMapViewDelegate

extension BankMapView: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        pinView.pinTintColor = DSKitAsset.Colors.blue.color
        return pinView
    }
}
