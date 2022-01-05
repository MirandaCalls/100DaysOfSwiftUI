//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Geoffrie Maiden Mueller on 1/3/22.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var size: String {
        switch self.resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: self.resort.price)
    }
    
    var body: some View {
        Group {
            Text("Size: \(self.size)")
                .layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(self.price)")
                .layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
