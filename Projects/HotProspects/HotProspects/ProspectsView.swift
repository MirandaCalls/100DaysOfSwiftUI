//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/19/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortBy {
        case name, dateAdded
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showingFilterActionSheet = false
    @State private var sortOrder: SortBy = .name
    
    let filter: FilterType

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
    
    var sortByLabel: String {
        switch self.sortOrder {
        case .name:
            return "Name"
        case.dateAdded:
            return "Date Added"
        }
    }
    
    var filteredProspects: [Prospect] {
        var prospects: [Prospect]
        
        switch self.filter {
        case .none:
            prospects = self.prospects.people
        case .contacted:
            prospects = self.prospects.people.filter { $0.isContacted }
        case .uncontacted:
            prospects = self.prospects.people.filter { !$0.isContacted }
        }
        
        return prospects.sorted {
            if self.sortOrder == .name {
                return $0.name < $1.name
            } else {
                return $0.dateAdded < $1.dateAdded
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        if prospect.isContacted && self.filter == .none {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(self.title)
            .navigationBarItems(
                leading: Button(action: {
                    self.showingFilterActionSheet = true
                }) {
                    Image(systemName: "arrow.down.circle.fill")
                    Text("\(self.sortByLabel)")
                },
                trailing: Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
        }
        .sheet(isPresented: self.$isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Kathryn Janeway\ncoffee@inthatnebula.com", completion: self.handleScan)
        }
        .actionSheet(isPresented: self.$showingFilterActionSheet) {
            ActionSheet(title: Text("Change Sort Order"), message: Text("Select value to sort by"), buttons: [
                .default(Text("Name")) { self.sortOrder = .name },
                .default(Text("Date Added")) { self.sortOrder = .dateAdded },
                .cancel()
            ])
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
            person.dateAdded = Date()
            
            self.prospects.add(person)
        case .failure(_):
            print("Scanning failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let add_request = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            // Runs different code when in the simulator
            #if targetEnvironment(simulator)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            #else
                var date_components = DateComponents()
                date_components.hour = 9
                let trigger = UNCalendarNotificationTrigger(dateMatching: date_components, repeats: false)
            #endif
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                add_request()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        add_request()
                    } else {
                        print("Failed to get required notification permissions.")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
