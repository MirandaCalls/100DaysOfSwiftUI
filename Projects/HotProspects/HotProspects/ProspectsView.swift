//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/19/21.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
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
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                    }
                }
            }
            .navigationBarTitle(self.title)
            .navigationBarItems(trailing: Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
        }
        .sheet(isPresented: self.$isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Tim Cook\ncoolemail@apple.com", completion: self.handleScan)
        }
    }
    
    func handleScan(result: Result<ScanResult, CodeScanner.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let data):
            let details = data.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.people.append(person)
        case .failure(_):
            print("Scanning failed")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
