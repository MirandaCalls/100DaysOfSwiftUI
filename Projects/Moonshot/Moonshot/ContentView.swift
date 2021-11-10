//
//  ContentView.swift
//  Moonshot
//
//  Created by Geoffrie Maiden Mueller on 11/6/21.
//

import SwiftUI

struct ContentView: View {
    let missions: [Mission] =  Bundle.main.decode("missions.json")
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        NavigationView {
            List(self.missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, allAstronauts: self.astronauts, allMissions: self.missions)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
