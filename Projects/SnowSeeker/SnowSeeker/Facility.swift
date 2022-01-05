//
//  Facility.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/4/22.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    let name: String
    
    var icon: some View {
        let icons = [
            "Accommodation": "house",
            "Beginners": "1.circle",
            "Cross-country": "map",
            "Eco-friendly": "leaf.arrow.circlepath",
            "Family": "person.3"
        ]
        
        if let iconName = icons[self.name] {
            let image = Image(systemName: iconName)
                .accessibility(label: Text(self.name))
                .foregroundColor(.secondary)
            return image
        } else {
            fatalError("Unknown facility type: \(self.name)")
        }
    }
    
    var alert: Alert {
        let messages = [
            "Accommodation": "This resort has popular on-site accommodation",
            "Beginners": "This resort has lots of ski schools",
            "Cross-country": "This resort has many cross-country ski routes",
            "Eco-friendly": "This resort has won an award for environmental friendliness",
            "Family": "This resort is popular with families"
        ]
        
        if let message = messages[self.name] {
            return Alert(title: Text(self.name), message: Text(message))
        } else {
            fatalError("Unknown facility type: \(self.name)")
        }
    }
}
