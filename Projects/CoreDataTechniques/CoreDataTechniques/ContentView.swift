//
//  ContentView.swift
//  CoreDataTechniques
//
//  Created by Geoffrie Maiden Mueller on 11/24/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        // HashableListDemo()
        // CheckForChangesDemo()
        CoreDataConstraintsDemo()
    }
}

struct BountyHunter: Hashable {
    var name: String
}

struct HashableListDemo: View {
    let bounty_hunters = [
        BountyHunter(name: "Spike Spiegel"),
        BountyHunter(name: "Faye Valentine")
    ]
    
    var body: some View {
        List(bounty_hunters, id: \.self) { hunter in
            Text("\(hunter.name)")
        }
    }
}

struct CheckForChangesDemo: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            if self.moc.hasChanges {
                try? self.moc.save()
                print("Saved changes")
            } else {
                print("No changes")
            }
        }
    }
}

struct CoreDataConstraintsDemo: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: SpaceTrucker.entity(), sortDescriptors: []) var truckers: FetchedResults<SpaceTrucker>
    
    var body: some View {
        VStack {
            List(truckers, id: \.self) { trucker in
                Text(trucker.name ?? "Unknown")
            }
            
            Button("Add") {
                let trucker = SpaceTrucker(context: self.moc)
                trucker.name = "Ellen Ripley"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
