//
//  LocationManager.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 22/06/23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        self.authorizationStatus = self.locationManager.authorizationStatus
        
        super.init()
        
        self.locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
