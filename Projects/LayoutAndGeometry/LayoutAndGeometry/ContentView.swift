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
        // CustomAlignmentGuideDemo()
        // PositionModifiersDemo()
        // GeometryReaderBasicsDemo()
        // CoordinateSpacesDemo()
        // ScrollViewEffectsDemo()
        TaylorSwiftAlbumShowcase()
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
            // By default align elements using their top edge
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
                        // Use the center line of this view to align with other views
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
                        // Make sure this element uses it's center line, just like the @genshinmemes text
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

struct PositionModifiersDemo: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                // .position returns a view that takes up all available space,
                // so that it can position the text wherever it wants to be placed.
                .position(x: 100, y: 100)
                // The color takes up whatever space the position view is taking up.
                // If placed before position, it would only take up the space the text takes up
                .background(.red)
                .frame(width: 300, height: 300)
            
            Text("Hello, world!")
                // Offset does not modify the original geometry, just repositions the view
                // to the specified location.
                .offset(x: 100, y: 100)
                // Red is rendered wherever the text used to be
                .background(.red)
        }
    }
}

struct GeometryReaderBasicsDemo: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, world!")
                    // Takes up 90% of the space GeometryReader was given to work with
                    .frame(width: geo.size.width * 0.9)
                    .background(.red)
            }
            .background(.green)
            
            // Pushed to bottom since Geometry reader takes up all available space
            Text("More text")
                .background(.blue)
        }
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        // Reads the middle X/Y position in regards to the whole screen
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        // X/Y position in regards to the bounds of OuterView
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        // X/Y position in regards to the closest parent, in this case, GeometryReader
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct CoordinateSpacesDemo: View {
    var body: some View {
        OuterView()
            .background(.red)
            // Defines a coordinate area named "Custom" that is defined by the bounds
            // of OuterView
            .coordinateSpace(name: "Custom")
    }
}

struct ScrollViewEffectsDemo: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(self.colors[index % 7])
                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct TaylorSwiftAlbumShowcase: View {
    let albums = ["taylor_swift", "fearless", "speak_now", "red", "ts_1989", "lover", "folklore"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { fullView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<50) { index in
                            GeometryReader { geo in
                                Image(self.albums[index % 7])
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                    .padding(.vertical)
                            }
                            .frame(width: 150)
                        }
                    }
                }
                .frame(width: fullView.size.width, height: fullView.size.height, alignment: .center)
            }
            .frame(height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
