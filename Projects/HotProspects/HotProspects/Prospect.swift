//
//  Prospect.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/19/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData.json"
    
    init() {
        self.people = []
        self.load()
    }
    
    private func save() {
        let data_url = FileManager.default.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            let encoded = try JSONEncoder().encode(self.people)
            try encoded.write(to: data_url, options: [.atomic])
        } catch {
            print("Failed to save \(Self.saveKey)")
        }
    }
    
    private func load() {
        let data_url = FileManager.default.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        var prospects: [Prospect]
        
        do {
            let data = try Data(contentsOf: data_url)
            prospects = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Failed to load \(Self.saveKey)")
            return
        }
        
        self.people = prospects
    }
    
    func add(_ prospect: Prospect) {
        self.people.append(prospect)
        self.save()
    }
    
    func toggle(_ prospect: Prospect) {
        // Always call this function first, before changing any values
        // So that SwiftUI will get the animations correct
        objectWillChange.send()
        
        prospect.isContacted.toggle()
        self.save()
    }
}
