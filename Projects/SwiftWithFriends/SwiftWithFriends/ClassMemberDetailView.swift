//
//  ClassMemberDetailView.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import SwiftUI

struct ClassMemberDetailView: View {
    var classMember: ClassMember
    var classmates: [ClassMember]
    var friends: [ClassMember]
    
    init(classMember: ClassMember, classmates: [ClassMember]) {
        self.classMember = classMember
        self.classmates = classmates
        self.friends = [ClassMember]()
        for friend_id in classMember.friendIds {
            let friend = classmates.first { classmate in
                classmate.id == friend_id
            }
            
            if friend != nil {
                self.friends.append(friend!)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ClassMemberLinkView(profileImageUrl: self.classMember.profileImageUrl, name: self.classMember.name, username: self.classMember.username)
            
            GroupBox(label:
                Label("Details", systemImage: "person.circle")
            ) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(classMember.description)
                    Text("Joined Twitter on \(classMember.joinedAtFormatted)")
                }
                .padding([.top], 1)
            }
            
            Text("Friends")
                .font(.title2)
                .fontWeight(.medium)
            if self.friends.count == 0 {
                Text("No friends yet, say hello to them on Twitter!")
                Spacer()
            } else {
                ScrollView(.vertical) {
                    ForEach(self.friends, id: \.id) { friend in
                        NavigationLink(destination: ClassMemberDetailView(classMember: friend, classmates: self.classmates)) {
                            ClassMemberLinkView(profileImageUrl: friend.profileImageUrl, name: friend.name, username: friend.username)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(Color.black)
                    }
                }
            }

        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle("@\(self.classMember.username)", displayMode: .inline)
    }
}

struct ClassMemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let class_member = ClassMember(
            id: "882060147325108225",
            username: "MirandaCalls",
            name: "Geoffrie Alena",
            description: "🏳️‍⚧️ Curious web developer with a deep love for anime and music. Learning Swift and iOS in #100DaysOfSwiftUI. Stay shiny everyone! (she/her)",
            profileImageUrl: "https://pbs.twimg.com/profile_images/1459648977104687109/9evn-YVz_normal.jpg",
            url: "https://t.co/TtFeKcMnZ4",
            joinedAt: Date(),
            friendIds: [
                "882060147325108225"
            ]
        )
        
        let classmates = [class_member]
        
        ClassMemberDetailView(classMember: class_member, classmates: classmates)
    }
}
