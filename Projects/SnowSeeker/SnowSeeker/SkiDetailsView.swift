//
//  SkiDetailView.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/3/22.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        VStack {
            Text("Elevation: \(self.resort.elevation)m")
            Text("Snow: \(self.resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
