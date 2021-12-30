//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Geoffrie Maiden Mueller on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // LayoutNotesDemo()
        // AlignmentDemo()
        CustomAlignmentGuideDemo()
    }
}

struct LayoutNotesDemo: View {
    var body: some View {
        /**
         * 1. Parent view proposes a size, then asks child how much it needs
         * 2. Child view determines how much space it needs and parent MUST respect that size
         * 3. Parent then positions child based on that size into its space
         *
         *  layout nuetral - Element determines its size by asking child element how much space it needs
         */
        VStack {
            // Reminder: modifiers create new views that wrap the existing view as a child element
            Text("Hello, world!")
                .padding(20)
                .background(Color.red)
            // If layout neutral view is used on its own, it will automatically take up all remaining space
            Color.blue
        }
    }
}

struct AlignmentDemo: View {
    var body: some View {
        VStack {
            Text("Live long and prosper")
                .frame(width: 200, height: 100, alignment: .topLeading)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                // Parent will also ask the child view how it should be aligned in comparison to other views it shares space with
                ForEach(0..<10) { position in
                    Text("Position \(position)")
                        .alignmentGuide(.leading) { d in
                            print(d)
                            // Positions the "leading" edge as -10 * 0..<10 pixels away from it's ordinary leading edge
                            return CGFloat(position) * -10
                        }
                }
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            // By default align all elements to top of the parent view
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuideDemo: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@genshinmemes")
                    .alignmentGuide(.midAccountAndName) { d in
                        // Make sure this element is at the center line of the view
                        d[VerticalAlignment.center]
                    }
                Image("LanternFestival")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("GENSHIN MEMES")
                    .alignmentGuide(.midAccountAndName) { d in
                        // Make sure this element is at the center line, just like the @genshinmemes text
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
