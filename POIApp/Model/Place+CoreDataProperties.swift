//
//  Place+CoreDataProperties.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 17/02/2025.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var address: String?

}

extension Place : Identifiable {

}
