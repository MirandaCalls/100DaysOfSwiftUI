//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Geoffrie Maiden Mueller on 12/28/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var reshuffleFailures = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Reshuffle failed cards into deck", isOn: self.$reshuffleFailures)
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: self.dismiss))
            .onAppear(perform: self.loadData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func loadData() {
        self.reshuffleFailures = UserDefaults.standard.bool(forKey: "reshuffleFailures")
    }
    
    func dismiss() {
        UserDefaults.standard.set(self.reshuffleFailures, forKey: "reshuffleFailures")
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
