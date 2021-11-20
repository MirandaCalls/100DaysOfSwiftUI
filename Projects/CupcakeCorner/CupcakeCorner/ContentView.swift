//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Geoffrie Maiden Mueller on 11/16/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appData = AppData()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $appData.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $appData.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(appData.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $appData.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if appData.order.specialRequestEnabled {
                        Toggle(isOn: $appData.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $appData.order.addSprinkles) {
                            Text("Add sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(appData: appData)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
