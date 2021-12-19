//
//  ContentView.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/16/21.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        .onAppear {
            let tabview_appearance = UITabBarAppearance()
            tabview_appearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabview_appearance
        }
        .environmentObject(self.prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
