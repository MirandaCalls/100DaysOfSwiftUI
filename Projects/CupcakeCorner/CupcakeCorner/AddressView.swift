//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Geoffrie Maiden Mueller on 11/17/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var appData: AppData
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $appData.order.name)
                TextField("Street Address", text: $appData.order.streetAddress)
                TextField("City", text: $appData.order.city)
                TextField("Zip", text: $appData.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(appData: appData)) {
                    Text("Check out")
                }
                .disabled(!appData.order.hasValidAddress)
            }
        }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(appData: AppData())
    }
}
