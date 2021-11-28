//
//  ClassMemberDetailView.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import SwiftUI

struct ClassMemberDetailView: View {
    var classMember: ClassMember
    
    var fetchRequest: FetchRequest<ClassMember>
    var friends: FetchedResults<ClassMember> {
        fetchRequest.wrappedValue
    }
    
    init(classMember: ClassMember) {
        self.classMember = classMember
        self.fetchRequest = FetchRequest(entity: ClassMember.entity(), sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ], predicate: NSPredicate(format: "id IN %@", classMember.friendIds))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ClassMemberLinkView(profileImageUrl: self.classMember.wrappedProfileImageUrl, name: self.classMember.wrappedName, username: self.classMember.wrappedUsername)
            
            GroupBox(label:
                Label("Details", systemImage: "person.circle")
            ) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(classMember.wrappedBio)
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
                        NavigationLink(destination: ClassMemberDetailView(classMember: friend)) {
                            ClassMemberLinkView(profileImageUrl: friend.wrappedProfileImageUrl, name: friend.wrappedName, username: friend.wrappedUsername)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(Color.black)
                    }
                }
            }

        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle("@\(self.classMember.wrappedUsername)", displayMode: .inline)
    }
}

struct ClassMemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let class_member = ClassMember(context: PersistenceController.preview.container.viewContext)
        class_member.id = "882060147325108225"
        class_member.name = "Geoffrie Alena"
        class_member.username = "MirandaCalls"
        class_member.bio = "🏳️‍⚧️ Curious web developer with a deep love for anime and music. Learning Swift and iOS in #100DaysOfSwiftUI. Stay shiny everyone! (she/her)"
        class_member.profileImageUrl = "https://pbs.twimg.com/profile_images/1459648977104687109/9evn-YVz_normal.jpg"
        class_member.url = "https://t.co/TtFeKcMnZ4"
        class_member.joinedAt = Date()
        
        return ClassMemberDetailView(classMember: class_member)
    }
}
