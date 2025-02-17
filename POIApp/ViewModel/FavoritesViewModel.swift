//
//  FavoritesViewModel.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//


import SwiftUI
import MapKit
import CoreData

class FavoritesViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""

    private let persistenceManager = PersistenceManager.shared

    func savePlace(name: String, address: String, latitude: Double, longitude: Double) {
        persistenceManager.savePlace(name: name, address: address, latitude: latitude, longitude: longitude) { message in
            DispatchQueue.main.async {
                self.alertMessage = message
                self.showAlert = true
            }
        }
    }

    func deletePlace(at offsets: IndexSet, savedPlaces: FetchedResults<Place>) {
        for index in offsets {
            let place = savedPlaces[index]
            persistenceManager.deletePlace(place: place)
        }
    }
}
