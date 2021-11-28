//
//  ContentView.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var classmates = [ClassMember]()
    
    var body: some View {
        NavigationView {
            List(self.classmates, id: \.id) { classMember in
                NavigationLink(destination: ClassMemberDetailView(classMember: classMember, classmates: self.classmates)) {
                    ClassMemberLinkView(profileImageUrl: classMember.profileImageUrl, name: classMember.name, username: classMember.username)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Classmates")
        }
        .onAppear {
            Networking.loadClassmates { classmates in
                self.classmates = classmates.sorted(by: {
                    $0.name < $1.name
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
