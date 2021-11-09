//
//  MissionView.swift
//  Moonshot
//
//  Created by Geoffrie Maiden Mueller on 11/8/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]();
        for role in mission.crew {
            if let match = astronauts.first(where: {
                $0.id == role.name
            } ) {
                matches.append(CrewMember(role: role.role, astronaut: match))
            } else {
                fatalError("Missing astronaut \(role.name)!")
            }
        }
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader() { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(0..<self.astronauts.count) { crewIndex in
                        let crew_member = self.astronauts[crewIndex]
                        NavigationLink(destination: AstronautView(astronaut: crew_member.astronaut)) {
                            HStack {
                                Image(crew_member.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(self.getOfficerColor(officerNumber: crewIndex), lineWidth: 3))
                                
                                VStack(alignment: .leading) {
                                    Text(crew_member.astronaut.name)
                                        .font(.headline)
                                    Text(crew_member.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func getOfficerColor(officerNumber: Int) -> Color {
        switch(officerNumber) {
        case 0:
            return Color.yellow
        case 1:
            return Color.blue
        default:
            return Color.red
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: self.astronauts)
    }
}
