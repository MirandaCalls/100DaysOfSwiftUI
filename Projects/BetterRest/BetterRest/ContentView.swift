//
//  ContentView.swift
//  BetterRest
//
//  Created by Geoffrie Maiden Mueller on 10/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var bedtime: String {
        calculateBedtime()
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your details")) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%G") hours")
                        }
                        .accessibilityElement(children: .combine)
                        .accessibility(value: Text("\(sleepAmount, specifier: "%G") hours"))
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Picker(selection: $coffeeAmount, label: EmptyView()) {
                            ForEach(1 ..< 21) {
                                if $0 == 1 {
                                    Text("1 cup")
                                } else {
                                    Text("\($0) cups")
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    }
                }
                
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Text("Your ideal bedtime is ...")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(bedtime).font(.title)
                        Spacer()
                    }
                }
                .padding(5)
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text("Your ideal bedtime is \(bedtime)"))
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let wake_hours = components.hour ?? 0
        let wake_minutes = components.minute ?? 0
        let wake_seconds = (wake_hours * 3600) + (wake_minutes * 60)
        
        do {
            let prediction = try model.prediction(wake: Double(wake_seconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            let wake_time = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: wake_time)
        } catch {
            return "Error"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
