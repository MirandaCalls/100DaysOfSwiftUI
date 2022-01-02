//
//  ContentView.swift
//  DiceRoller
//
//  Created by Geoffrie Maiden Mueller on 1/1/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            RollDiceTab()
                .tabItem {
                    Image(systemName: "die.face.6")
                    Text("Roll Dice")
                }
            History()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("History")
                }
        }
        .onAppear {
            let tabview_appearance = UITabBarAppearance()
            tabview_appearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabview_appearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
