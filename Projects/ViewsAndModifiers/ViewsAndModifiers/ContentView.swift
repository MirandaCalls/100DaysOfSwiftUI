//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Geoffrie Maiden Mueller on 10/21/21.
//

import SwiftUI

struct ContentView: View {
    var lyric1: some View {
        Text("It's been a long time,")
    }
    var lyric2 = Text("Getting from day to year")
    
    // Opaque return type
    var body: some View {
        VStack {
            // Views only take up as much space as their content does
            // There is nothing "behind the view" to style, only YOUR views you create here
            Text("Hello, world!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
            
            Button("Hello world") {
                print(type(of: self.body))
            }
            // These modifiers are processed in order, returning a nested ModifiedContent
            // With view to modify and the operation to perform
            .frame(width: 200, height: 200)
            .background(Color.red)
            .padding()
            .background(Color.orange)
            .padding()
            .background(Color.blue)
            .padding()
            .background(Color.green)
            
            // Environment modifiers
            // Applying a modifier to container views can affect the whole contents of the view
            VStack {
                Text("Gryffindor")
                Text("Hufflepuff")
                // In this case, this modifier overrides the container modifier
                    .font(.largeTitle)
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            
            // Views as properties
            VStack {
                lyric1
                lyric2
            }
            
            // Custom modifiers
            VStack {
                Text("Big Fish")
                    .titleStyle()
                
                Color.blue
                    .frame(width: 200, height: 200)
                    .watermarked(with: "Hacking with Swift")
            }
        }
    }
}

struct SpecialModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.red)
            .font(.largeTitle)
    }
}

struct Watermarked: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(SpecialModifier())
    }
    
    func watermarked(with text: String) -> some View {
        self.modifier(Watermarked(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
