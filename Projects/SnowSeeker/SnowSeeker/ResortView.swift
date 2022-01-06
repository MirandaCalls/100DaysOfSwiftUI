//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/3/22.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    let resort: Resort
    
    @State private var selectedFacility: Facility?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: self.resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Photo: \(self.resort.imageCredit)")
                        .font(.caption)
                        .padding(2)
                        .background(.black.opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        .padding(4)
                }
                
                Group {
                    HStack {
                        if self.sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: self.resort) }
                            VStack { SkiDetailsView(resort: self.resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: self.resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: self.resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(self.resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(self.resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(self.favorites.contains(self.resort) ? "Remove from favorites" : "Add to favorites") {
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                    } else {
                        self.favorites.add(self.resort)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("\(self.resort.name), \(self.resort.country)")
        .alert(item: self.$selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
