//
//  SearchViewModel.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//


import MapKit
import SwiftUI

class SearchViewModel: NSObject, ObservableObject {
    @Published var annotations: [MKPointAnnotation] = []
    @Published var region: MKCoordinateRegion
    
    init(region: MKCoordinateRegion) {
        self.region = region
    }

    func searchForPlaces(searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, !response.mapItems.isEmpty else {
                print("⚠️ No results found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                self.annotations = response.mapItems.map { item in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    return annotation
                }

                if let firstItem = response.mapItems.first {
                    self.region = MKCoordinateRegion(
                        center: firstItem.placemark.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                }
            }
        }
    }
}
