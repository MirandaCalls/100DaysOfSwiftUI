//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/19/21.
//

import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    var title: String {
        switch self.filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    let filter: FilterType
    var filteredProspects: [Prospect] {
        switch self.filter {
        case .none:
            return self.prospects.people
        case .contacted:
            return self.prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return self.prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(self.title)
            .navigationBarItems(trailing: Button(action: {
                let prospect = Prospect()
                prospect.name = "Malcolm Reynolds"
                prospect.emailAddress = "mal@serenity.com"
                self.prospects.people.append(prospect)
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
