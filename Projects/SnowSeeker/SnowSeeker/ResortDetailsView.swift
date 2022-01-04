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
        VStack {
            Text("Size: \(self.size)")
            Text("Price: \(self.price)")
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
