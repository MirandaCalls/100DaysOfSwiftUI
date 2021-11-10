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
    let allMissions: [Mission]
    
    init(mission: Mission, allAstronauts: [Astronaut], allMissions: [Mission]) {
        self.mission = mission
        self.allMissions = allMissions
        
        var matches = [CrewMember]();
        for role in mission.crew {
            if let match = allAstronauts.first(where: {
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
                VStack(spacing: 15) {
                    VStack {
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.7)
                            .padding(.top)
                        
                        VStack {
                            Text("LAUNCHED")
                                .font(.subheadline)
                            Text(self.mission.formattedLaunchDate)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(0..<self.astronauts.count) { crewIndex in
                        let crew_member = self.astronauts[crewIndex]
                        NavigationLink(destination: AstronautView(astronaut: crew_member.astronaut, allMissions: self.allMissions)) {
                            AstronautLink(astronaut: crew_member.astronaut, role: crew_member.role, positionIndex: crewIndex)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct AstronautLink: View {
    let astronaut: Astronaut
    let role: String
    let positionIndex: Int
    
    var body: some View {
        HStack {
            Image(self.astronaut.id)
                .resizable()
                .frame(width: 83, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(self.getOfficerColor(officerNumber: self.positionIndex), lineWidth: 3))
            
            VStack(alignment: .leading) {
                Text(self.astronaut.name)
                    .font(.headline)
                Text(self.role)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
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
        MissionView(mission: missions[0], allAstronauts: self.astronauts, allMissions: missions)
    }
}
