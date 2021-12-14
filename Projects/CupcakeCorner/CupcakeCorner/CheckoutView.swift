//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Geoffrie Maiden Mueller on 11/17/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var appData: AppData
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)
                    
                    Text("Your total is $\(appData.order.cost, specifier: "%.2f")")
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(appData.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                showErrorAlert()
                return
            }
            
            if let decoded = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decoded.quantity) \(Order.types[decoded.type].lowercased()) cupcakes is on its way."
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
                showErrorAlert()
            }
        }.resume()
    }
    
    func showErrorAlert() {
        self.confirmationTitle = "Error"
        self.confirmationMessage = "Failed to place order. Please wait and try again."
        self.showingConfirmation = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(appData: AppData())
    }
}
