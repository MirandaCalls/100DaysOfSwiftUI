//
//  FiltersView.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/5/22.
//

import SwiftUI

/**
 * 💩🔥💩🔥💩🔥💩🔥💩🔥 WARNING 💩🔥💩🔥💩🔥💩🔥💩🔥
 * This file contains some of my least favorite code I have ever written.
 * I WILL be coming back to fix this and make it better, so if you see it before then,
 * I apologize to your eyeballs.
 */

struct FiltersView: View {
    @Environment(\.presentationMode) var presentationMode
    let onDismiss: ([Resort]) -> Void
    
    let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    
    let sortOptions = ["Default", "Name", "Country"]
    let filterOptions = ["Country", "Size", "Price"]
    
    let countries = ["France", "Austria", "United States", "Italy", "Canada"]
    let sizes = ["Small", "Average", "Large"]
    let prices = ["$", "$$", "$$$"]
    
    @State private var sortChoice = 0
    @State private var sortAscending = true
    
    @State private var filterResorts = false
    @State private var filterChoice = 0
    @State private var filterValues = ["France", "Austria", "United States", "Italy", "Canada"]
    @State private var selectedFilterValues = Set([0, 1, 2, 3, 4])
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sorting")) {
                    HStack {
                        Text("Sort by")
                        Spacer()
                        Picker("Sort by", selection: self.$sortChoice) {
                            ForEach(0..<self.sortOptions.count, id: \.self) { index in
                                Text(self.sortOptions[index])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .font(.body)
                    }
                    
                    if self.sortChoice != 0 {
                        HStack {
                            Text("Direction")
                            Spacer()
                            Button(self.sortAscending ? "Asc" : "Desc") {
                                self.sortAscending.toggle()
                            }
                        }
                    }
                }
                
                Section(header: Text("Filter")) {
                    Toggle("Filter Resorts", isOn: self.$filterResorts)
                    if self.filterResorts {
                        HStack {
                            Text("Filter by")
                            Spacer()
                            Picker("Filter by", selection: self.$filterChoice) {
                                ForEach(0..<self.filterOptions.count, id: \.self) { index in
                                    Text(self.filterOptions[index])
                                }
                            }.onChange(of: self.filterChoice) { newValue in
                                if newValue == 0 {
                                    self.filterValues = countries
                                    self.selectedFilterValues = Set(0..<countries.count)
                                } else if newValue == 1 {
                                    self.filterValues = sizes
                                    self.selectedFilterValues = Set(0..<sizes.count)
                                } else {
                                    self.filterValues = prices
                                    self.selectedFilterValues = Set(0..<prices.count)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                }
                
                if self.filterResorts {
                    Section(header: Text("Show selected")) {
                        ForEach(0..<self.filterValues.count, id: \.self) { index in
                            HStack {
                                Text(self.filterValues[index])
                                Spacer()
                                Button(action: {
                                    if self.selectedFilterValues.contains(index) {
                                        self.selectedFilterValues.remove(index)
                                    } else {
                                        self.selectedFilterValues.insert(index)
                                    }
                                }) {
                                    if self.selectedFilterValues.contains(index) {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Filters")
            .navigationBarItems(trailing:
                Button("Done") {
                    self.saveFilters()
                    self.onDismiss(self.sortAndFilterResorts())
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
            .onAppear {
                self.loadFilters()
            }
        }
    }
    
    func sortAndFilterResorts() -> [Resort] {
        var filtered = self.allResorts
        if self.sortChoice != 0 {
            filtered = filtered.sorted {
                var a_first: Bool
                if self.sortChoice == 1 {
                    a_first = $0.name < $1.name
                } else {
                    a_first = $0.country < $1.country
                }
                
                if !self.sortAscending {
                    a_first.toggle()
                }
                
                return a_first
            }
        }
        
        if self.filterResorts {
            if self.filterChoice == 0 {
                // countries
                let country_set = self.selectedFilterValues.map {
                    countries[$0]
                }
                
                filtered = filtered.filter {
                    country_set.contains($0.country)
                }
            } else if self.filterChoice == 1 {
                let sizes_set = self.selectedFilterValues.map {
                    $0 + 1
                }
                
                // sizes
                filtered = filtered.filter {
                    sizes_set.contains($0.size)
                }
            } else {
                let prices_set = self.selectedFilterValues.map {
                    $0 + 1
                }
                
                // prices
                filtered = filtered.filter {
                    prices_set.contains($0.price)
                }
            }
        }
        
        return filtered
    }
    
    func loadFilters() {
        self.sortChoice = UserDefaults.standard.integer(forKey: "SortChoice")
        self.sortAscending = UserDefaults.standard.bool(forKey: "SortAscending")
        self.filterResorts = UserDefaults.standard.bool(forKey: "FilterResorts")
        self.filterChoice = UserDefaults.standard.integer(forKey: "FilterChoice")
        if let filterValues = UserDefaults.standard.array(forKey: "FilterValues") as? [String] {
            self.filterValues = filterValues
        }
        if let selectedFilterValues = UserDefaults.standard.array(forKey: "SelectedFilterValues") as? [Int] {
            self.selectedFilterValues = Set(selectedFilterValues)
        }
    }
    
    func saveFilters() {
        UserDefaults.standard.set(self.sortChoice, forKey: "SortChoice")
        UserDefaults.standard.set(self.sortAscending, forKey: "SortAscending")
        UserDefaults.standard.set(self.filterResorts, forKey: "FilterResorts")
        UserDefaults.standard.set(self.filterChoice, forKey: "FilterChoice")
        UserDefaults.standard.set(self.filterValues, forKey: "FilterValues")
        UserDefaults.standard.set(Array(self.selectedFilterValues), forKey: "SelectedFilterValues")
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView() { resorts in
            print("dismissed")
        }
    }
}
