//
//  ContactLinkView.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/14/21.
//

import SwiftUI

struct ContactLinkView: View {
    var contact: Contact
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: self.contact.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(Color(red: 191 / 255, green: 191 / 255, blue: 191 / 255))
            
            Text(self.contact.wrappedName)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 4, x: 4, y: 4)
    }
}
