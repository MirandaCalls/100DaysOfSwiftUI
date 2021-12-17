/**
 * Day 79
 * EnvironmentObject, TabView
 **/

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
	// Pulls whatever environment object that matches User type that the parent view has shared
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObjectDemo: View {
    let user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        // Shares the user object to all child views
        // NOTE: This object is not shared with sheets
        .environmentObject(user)
    }
}

struct TabViewDemo: View {
	// State allows you to programatically switch tabs
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                	// Only 1 image and 1 text view will be displayed, even if you add more to the .tabItem
                    Image(systemName: "star")
                    Text("One")
                }
                // tag(): Unique value the TabView uses to track which tab is which. Can use strings as well as ints
                .tag(0)
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(1)
        }
        .onAppear {
            // Needed extra configuration for TabView, otherwise mine had no background
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}