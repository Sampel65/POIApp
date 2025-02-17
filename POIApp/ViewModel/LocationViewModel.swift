//
//  LocationViewModel.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    var cancellables = Set<AnyCancellable>()

    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationStatus()
    }

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }

    private func checkAuthorizationStatus() {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied.")
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.location = newLocation
            self.region.center = newLocation.coordinate
        }
    }
}


//class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//    @Published var location: CLLocation?
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//    @Published var authorizationStatus: CLAuthorizationStatus?
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        checkAuthorization()
//    }
//
//    func requestLocation() {
//        if CLLocationManager.locationServicesEnabled() {
//            manager.requestWhenInUseAuthorization()
//            manager.startUpdatingLocation()
//        }
//    }
//
//    private func checkAuthorization() {
//        authorizationStatus = manager.authorizationStatus
//        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
//            manager.startUpdatingLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last else { return }
//        DispatchQueue.main.async {
//            self.location = newLocation
//            if self.region.center.latitude == 37.7749 && self.region.center.longitude == -122.4194 {
//                // Update only if this is the first update
//                self.region = MKCoordinateRegion(
//                    center: newLocation.coordinate,
//                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                )
//            }
//        }
////        manager.stopUpdatingLocation() // Stop further updates after first location
//    }
//
//}
