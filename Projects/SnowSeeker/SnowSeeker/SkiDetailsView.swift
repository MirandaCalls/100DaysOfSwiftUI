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
        Group {
            Text("Elevation: \(self.resort.elevation)m")
                .layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Snow: \(self.resort.snowDepth)cm")
                .layoutPriority(1)
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
