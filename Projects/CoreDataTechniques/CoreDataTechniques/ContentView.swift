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
        // CoreDataConstraintsDemo()
        // PredicateDemo()
        DynamicFilteringDemo()
        // CoreDataRelationships()
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

struct PredicateDemo: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe in %@", ["Firefly", "Cowboy Bebop"])) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Serenity"
                ship1.universe = "Firefly"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Voyager"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Bebop"
                ship3.universe = "Cowboy Bebop"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Ebon Hawk"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
        }
    }
}

enum FilteredListOptions {
    case beginsWith, contains
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    let content: (T) -> Content
    
    var body: some View {
        List(singers, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(
        filterModifier: FilteredListOptions,
        filterKey: String,
        filterValue: String,
        sortDescriptors: [NSSortDescriptor],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        var predicate: NSPredicate? = nil
        if filterModifier == FilteredListOptions.beginsWith && filterValue != "" {
            predicate = NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
        } else if filterModifier == FilteredListOptions.contains {
            predicate = NSPredicate(format: "%K LIKE \"*\(filterValue)*\"", filterKey, filterValue)
        }
        
        self.fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
}

struct DynamicFilteringDemo: View {
    let filterOptions = [
        FilteredListOptions.beginsWith,
        FilteredListOptions.contains
    ]
    let filterOptionsLabels = [
        "BEGINS WITH",
        "CONTAINS"
    ]
    
    @Environment(\.managedObjectContext) var moc
    @State private var filterType = 0
    @State private var lastNameFilter = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Last Name Search")
                
                Picker("Selection", selection: $filterType) {
                    ForEach(0..<filterOptions.count) {
                        Text("\(filterOptionsLabels[$0])")
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Search", text: $lastNameFilter)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
            }
            .padding()
            
            FilteredList(filterModifier: self.filterOptions[self.filterType], filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: [
                NSSortDescriptor(key: "firstName", ascending: true)
            ]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
        }
    }
}

struct CoreDataRelationships: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add examples") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
