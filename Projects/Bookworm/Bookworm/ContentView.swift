//
//  ContentView.swift
//  Bookworm
//
//  Created by Geoffrie Maiden Mueller on 11/20/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Text("Hello world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
