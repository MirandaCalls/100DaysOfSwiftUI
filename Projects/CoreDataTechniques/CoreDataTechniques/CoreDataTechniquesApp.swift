//
//  CoreDataTechniquesApp.swift
//  CoreDataTechniques
//
//  Created by Geoffrie Maiden Mueller on 11/24/21.
//

import SwiftUI

@main
struct CoreDataTechniquesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
