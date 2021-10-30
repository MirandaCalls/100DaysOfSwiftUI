//
//  ContentView.swift
//  Animations
//
//  Created by Geoffrie Maiden Mueller on 10/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        ImplicitAnimatedButton()
        // AnimatedBinding()
        // ExplicitAnimation()
    }
}

struct ImplicitAnimatedButton: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap me!") {
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct AnimatedBinding: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            Spacer()
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct ExplicitAnimation: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
