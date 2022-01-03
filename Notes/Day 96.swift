/**
 * Day 96
 * Side by side Views, Alerts & Optionals, Group views
 **/

import SwiftUI

struct SideBySideViews: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Secondary")) {
                Text("Hello, world!")
                    .padding()
            }
            .navigationBarTitle("Primary")
            
            // On large devices like iPhone Max and iPads
            // a secondary view can be shown next to the primary/sidebar view
            
            // This view will be loaded initially with the primary
            
            // When a navigation link is tapped in the primary view
            // the secondary view is replaced with the destination content
            Text("Secondary")
        }
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct AlertsWithOptionalsDemo: View {
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                self.selectedUser = User()
            }
            // When the alert is complete, selectedUser will be set back to nil
            .alert(item: self.$selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

struct CaptainView: View {
    var body: some View {
        // Groups have transparent layout behavior
        // which means whatever parent the view is placed in
        // will decide how the grouped views are displayed
        
        // We don't know if the views will be displayed vertically, horizontally, or by depth
        Group {
            Text("Name: Malcolm Reynolds")
            Text("Ship: Serenity")
            Text("Current Job: Train Job")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack {
                    // Text views are rendered in a single column
                    CaptainView()
                }
            } else {
                HStack {
                    // Text views are rendered in a single row
                    CaptainView()
                }
            }
        }
    }
}