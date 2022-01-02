//
//  DiceRollerApp.swift
//  DiceRoller
//
//  Created by Geoffrie Maiden Mueller on 1/1/22.
//

import SwiftUI

@main
struct DiceRollerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
