/**
 * Day 20
 * Stacks, colors, gradients, buttons, images, alerts
 */

import SwiftUI
import PlaygroundSupport

struct StackDemonstrations: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello, world!")
            Text("Hello, world 2!")
            HStack(spacing: 20) {
                Text("Hello, world!")
                Text("Hello, world 2!")
            }
            ZStack(alignment: .top) {
                Text("Hello, world!")
                    .padding()
                Text("This is inside a stack")
            }
            Spacer()
        }
    }
}

struct ColorsAndFrames: View {
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            Text("Your Content")
        }
    }
}

struct FunWithGradients: View {
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
            AngularGradient(gradient: Gradient(colors: [.red, .green, .yellow, .blue, .orange, .pink]), center: .center)
        }
    }
}

struct ButtonsAndImages: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Button was tapped!")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Tap Me!")
                }
            }
        }
    }
}

struct AlertView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Hello SwiftUI"), message: Text("Example alert message"), dismissButton: .default(Text("OK")))
        }
    }
}

PlaygroundPage.current.setLiveView(StackDemonstrations())
