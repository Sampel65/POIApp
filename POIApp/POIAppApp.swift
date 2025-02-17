//
//  POIAppApp.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 16/02/2025.
//

import SwiftUI
@main
struct POIFinderApp: App {
    let persistenceController = PersistenceManager.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.viewContext) 
        }
    }
}
