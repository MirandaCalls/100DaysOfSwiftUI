//
//  ContentView.swift
//  BucketList
//
//  Created by Geoffrie Maiden Mueller on 12/5/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    @State private var displayErrorSheet = false
    @State private var displayedError = ""
    
    var body: some View {
        ZStack {
            if self.isUnlocked {
                BucketListMapView()
            } else {
                LinearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Bucket List")
                                .font(.largeTitle)
                            Image(systemName: "lock")
                                .font(.largeTitle)
                        }
                        Text("Securely storing your plans for the future.")
                            .padding(.top)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.authenticate()
                    }) {
                        Text("Unlock Data")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding([.leading, .trailing])
                    }
                }
            }
        }
        .alert(isPresented: self.$displayErrorSheet) {
            Alert(title: Text("Error"), message: Text(self.displayedError), dismissButton: .default(Text("OK")))
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.displayErrorSheet = true
                        self.displayedError = authenticationError?.localizedDescription ?? "Unknown error"
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
