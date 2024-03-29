//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/2/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var filtersSheetOpen = false
    
    var body: some View {
        NavigationView {
            List(self.resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing:
                Button("Filters") {
                    self.filtersSheetOpen = true
                }
            )
            .sheet(isPresented: self.$filtersSheetOpen) {
                FiltersView() { filteredResorts in
                    self.resorts = filteredResorts
                }
            }
            
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        .environmentObject(self.favorites)
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(.stack))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
