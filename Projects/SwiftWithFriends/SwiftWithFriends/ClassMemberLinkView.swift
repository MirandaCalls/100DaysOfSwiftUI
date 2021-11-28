//
//  ClassMemberLinkView.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import SwiftUI

struct ClassMemberLinkView: View {
    var profileImageUrl: String
    var name: String
    var username: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: self.profileImageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64, height: 64)
            .clipShape(Circle())
            .shadow(color: Color.gray, radius: 3, x: 0, y: 3)

            VStack(alignment: .leading) {
                Text(self.name)
                    .font(.headline)
                Text("@\(self.username)")
                    .font(.subheadline)
            }
        }
    }
}

struct ClassMemberLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ClassMemberLinkView(
            profileImageUrl: "https://pbs.twimg.com/profile_images/1459648977104687109/9evn-YVz_normal.jpg",
            name: "Geoffrie Alena",
            username: "MirandaCalls"
        )
    }
}
