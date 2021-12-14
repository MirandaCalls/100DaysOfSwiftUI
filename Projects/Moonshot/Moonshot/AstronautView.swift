//
//  AstronautView.swift
//  Moonshot
//
//  Created by Geoffrie Maiden Mueller on 11/8/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut, allMissions: [Mission]) {
        self.astronaut = astronaut

        var matches = [Mission]()
        for mission in allMissions {
            for role in mission.crew {
                if role.name == astronaut.id {
                    // Found mission this astronaut served on
                    matches.append(mission)
                }
            }
        }
        self.missions = matches
    }
    
    var body: some View {
        GeometryReader() { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(label: Text(astronaut.name))
                    
                    Text(self.astronaut.description)
                        .padding()
                    
                    VStack(spacing: 5) {
                        Text("SERVED ON")
                            .font(.subheadline)
                        
                        HStack {
                            ForEach(self.missions) { mission in
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .accessibility(label: Text(mission.displayName))
                                    .accessibility(removeTraits: .isImage)
                            }
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], allMissions: missions)
    }
}
