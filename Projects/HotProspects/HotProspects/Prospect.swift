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
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        // Always call this function first, before changing any values
        // So that SwiftUI will get the animations correct
        objectWillChange.send()
        
        prospect.isContacted.toggle()
    }
}
