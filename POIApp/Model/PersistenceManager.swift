//
//  PersistenceManager.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//


import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "POIApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    func savePlace(name: String, address: String, latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %lf AND longitude == %lf", latitude, longitude)
        
        do {
            let existingPlaces = try viewContext.fetch(request)
            if existingPlaces.isEmpty {
                let place = Place(context: viewContext)
                place.name = name
                place.address = address
                place.latitude = latitude
                place.longitude = longitude
                try viewContext.save()
                completion("Favorite location saved successfully")
            } else {
                completion("This place already exists in favorites.")
            }
        } catch {
            completion("Failed to save place: \(error.localizedDescription)")
        }
    }

    func fetchAllPlaces() -> [Place] {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        return (try? viewContext.fetch(request)) ?? []
    }

    func deletePlace(place: Place) {
        viewContext.delete(place)
        try? viewContext.save()
    }
}

