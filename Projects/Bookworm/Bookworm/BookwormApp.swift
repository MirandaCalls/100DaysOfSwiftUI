//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Geoffrie Maiden Mueller on 11/20/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
