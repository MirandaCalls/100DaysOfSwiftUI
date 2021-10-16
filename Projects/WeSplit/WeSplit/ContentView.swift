//
//  ContentView.swift
//  WeSplit
//
//  Created by Geoffrie Maiden Mueller on 10/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    var totalPerPerson: String {
        let check_amount = Double(checkAmount) ?? 0
        let total_people = Double(self.numberOfPeople + 2)
        
        let tip_percent = Double(tipPercentages[tipPercentage]) / 100
        let tip_total = check_amount * tip_percent
        
        let split_total = (check_amount + tip_total) / total_people
        
        return String(format: "%.2f", split_total)
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    			
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total Per Person")) {
                    Text("$\(totalPerPerson)")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
