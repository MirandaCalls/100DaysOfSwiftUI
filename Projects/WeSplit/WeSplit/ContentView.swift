//
//  ContentView.swift
//  WeSplit
//
//  Created by Geoffrie Maiden Mueller on 10/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var calculateButtonShown = true
    @State private var totalsShown = false
    @State private var warningShown = false
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    			
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                        .onChange(of: checkAmount) { newValue in
                            onTextFieldChange()
                        }
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                        .onChange(of: numberOfPeople) { newValue in
                            onTextFieldChange()
                        }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: tipPercentage) { newValue in
                        warningShown = newValue == 4
                    }
                }
                
                if calculateButtonShown {
                    Button("Calculate") {
                        if (checkAmount == "" || numberOfPeople == "") {
                            return
                        }
                        
                        hideKeyboard()
                        calculateButtonShown = false
                        totalsShown = true
                    }
                }
                
                if totalsShown {
                    let total_bill = calculateAmountPlusTip()
                    let total_per_person = total_bill / sanitizeTotalPeople()
                    
                    Section(header: Text("Amount + Tip")) {
                        Text("$\(total_bill, specifier: "%.2f")").foregroundColor(warningShown ? Color.red : Color.black)
                    }
                    Section(header: Text("Amount Per Person")) {
                        Text("$\(total_per_person, specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle("WeSplit")
        }
    }
    
    func onTextFieldChange() {
        self.calculateButtonShown = true
        self.totalsShown = false
    }
    
    func sanitizeTotalPeople() -> Double {
        // Convert the string to an int first if they attached another keyboard and typed a floating point
        let converted_people = Int(numberOfPeople) ?? 0
        return Double(converted_people)
    }
    
    func calculateAmountPlusTip() -> Double {
        let check_amount = Double(checkAmount) ?? 0
        
        let tip_percent = Double(tipPercentages[tipPercentage]) / 100
        let tip_total = check_amount * tip_percent
        
        return check_amount + tip_total
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
