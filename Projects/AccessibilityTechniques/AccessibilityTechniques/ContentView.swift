//
//  ContentView.swift
//  AccessibilityTechniques
//
//  Created by Geoffrie Maiden Mueller on 12/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // AccessibleViewsWithLabels()
        // HidingAndGroupingViews()
        AccessibleSteppersAndSliders()
    }
}

struct AccessibleViewsWithLabels: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            // Label to read out when selected
            // Otherwise the image filename is read out
            .accessibility(label: Text(labels[selectedPicture]))
            // Tells the user this is a button element
            .accessibility(addTraits: .isButton)
            // Makes sure the element is not treated as an image
            .accessibility(removeTraits: .isImage)
            .onTapGesture {
                self.selectedPicture = Int.random(in: 0...3)
            }
    }
}

struct HidingAndGroupingViews: View {
    var body: some View {
        Image("galina-n-189483")
            // Makes the image hidden from a voiceover user
            .accessibility(hidden: true)
        
        // Other way of hiding an image, the image is decorative instead of
        // important to understand the interface.
        Image(decorative: "galina-n-189483")
        
        // .combine will add a pause between reading the two Text views
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .combine)
        
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        // .ignore will skip reading the text inside the VStack
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Your score is 1000"))
    }
}

struct AccessibleSteppersAndSliders: View {
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        Slider(value: $estimate, in: 0...50)
            .padding()
            // value: Lets you customize the voiceover of what value the slider is at
            .accessibility(value: Text("\(Int(estimate))"))
        
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            // This modifier is supposed to read out the text when the stepper is changed
            // But on my iOS 15 phone, the labels of the "decrement" and "increment" buttons are the only things read
            .accessibility(value: Text("\(rating) out of 5"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
