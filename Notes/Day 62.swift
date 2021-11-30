/**
 * Day 62
 * Custom bindings and ActionSheet
 */

import PlaygroundSupport
import SwiftUI

struct CustomBindingDemo: View {
    // You shouldn't attach didSet{} handlers to @State, since it's a struct that wraps the actual value
    // didSet{} would only run when the State struct changes, which will never happen
    @State private var blurAmount: CGFloat = 0
    
    var body: some View {
        // We need to create our own custom binding so that we can run a function when blurAmount changes
        let blur = Binding<CGFloat> (
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            // Custom binding in use
            Slider(value: blur, in: 0...20)
        }
    }
}

// Action sheets are alternatives to Alerts
// Menu slides up from the bottom of the screen
struct ActionSheetDemo: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello world!")
            .frame(width: 300, height: 300)
            .background(self.backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change Background"), message: Text("Select a new color"), buttons: [
                    .default(Text("Red")) { self.backgroundColor = Color.red },
                    .default(Text("Green")) { self.backgroundColor = Color.green },
                    .default(Text("Blue")) { self.backgroundColor = Color.blue },
                    .cancel()
                ])
            }
    }
}

PlaygroundPage.current.setLiveView(CustomBindingDemo())
