//
//  HomeViewModel.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//


import SwiftUI
import MapKit
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isFirstLocationUpdate = true
    @Published var selectedPlace: MKMapItem?
    @Published var showPlaceDetail = false

    @Published var region: MKCoordinateRegion
    @Published var annotations: [MKPointAnnotation] = []

    private var locationViewModel = LocationViewModel()
    private var searchViewModel: SearchViewModel

    init() {
        self.searchViewModel = SearchViewModel(region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        self.region = searchViewModel.region

        setupLocationUpdates()
    }

    private func setupLocationUpdates() {
        locationViewModel.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                guard let self = self, self.isFirstLocationUpdate else { return }
                let userRegion = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
                DispatchQueue.main.async {
                    self.region = userRegion
                    self.searchViewModel.region = userRegion
                    self.isFirstLocationUpdate = false
                }
            }
            .store(in: &locationViewModel.cancellables)
    }

    func searchForPlaces() {
        searchViewModel.searchForPlaces(searchText: searchText)
    }

    func resetToUserLocation() {
        if let userLocation = locationViewModel.location {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )

            DispatchQueue.main.async {
                self.region = userRegion
                self.annotations = []
            }
        }
    }

    func requestLocation() {
        locationViewModel.requestLocation()
    }
}
