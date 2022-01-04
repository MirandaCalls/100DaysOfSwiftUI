//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/3/22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: self.resort.id)
                    .resizable()
                    .scaledToFit()
                
                Group {
                    HStack {
                        Spacer()
                        ResortDetailsView(resort: self.resort)
                        SkiDetailsView(resort: self.resort)
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(self.resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    Text(ListFormatter.localizedString(byJoining: self.resort.facilities))
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle("\(self.resort.name), \(self.resort.country)")
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
