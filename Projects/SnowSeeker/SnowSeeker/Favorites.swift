//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/4/22.
//

import SwiftUI

class Favorites: ObservableObject {
    private let saveKey = "Favorites"
    
    private var resorts: Set<String>
    
    init() {
        // load our saved data
        
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        self.resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        
        self.resorts.insert(resort.id)
        self.save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        
        self.resorts.remove(resort.id)
        self.save()
    }
    
    func save() {
        // write out our data
    }
}
