//
//  ContentView.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: ClassMember.entity(), sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ]) var classmates: FetchedResults<ClassMember>
    
    @State private var online = true
    
    var body: some View {
        NavigationView {
            List(self.classmates, id: \.id) { classMember in
                NavigationLink(destination: ClassMemberDetailView(classMember: classMember)) {
                    ClassMemberLinkView(profileImageUrl: classMember.wrappedProfileImageUrl, name: classMember.wrappedName, username: classMember.wrappedUsername)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Classmates")
            .navigationBarItems(
                trailing: HStack {
                    if self.online {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(Color.red)
                    }
                    Text(self.online ? "Online" : "Offline")
                }
            )
        }
        .onAppear {
            Networking.loadClassmates(
                completionHandler: { dtos in
                    self.deleteAllData()
                    self.storeIntoCoreData(dtos)
                },
                errorHandler: {
                    self.online = false
                }
            )
        }
    }
    
    func deleteAllData() {
        for class_member in self.classmates {
            self.moc.delete(class_member)
        }
        
        try? self.moc.save()
    }
    
    func storeIntoCoreData(_ data: [ClassMemberDto]) {
        for classMemberDto in data {
            let class_member = ClassMember(context: self.moc)
            class_member.id = classMemberDto.id
            class_member.name = classMemberDto.name
            class_member.username = classMemberDto.username
            class_member.bio = classMemberDto.description
            class_member.profileImageUrl = classMemberDto.profileImageUrl
            class_member.joinedAt = classMemberDto.joinedAt

            for friend_id in classMemberDto.friendIds {
                let friend = Friend(context: self.moc)
                friend.id = friend_id
                friend.classMember = class_member
                class_member.addToFriends(friend)
            }
        }

        try? self.moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
