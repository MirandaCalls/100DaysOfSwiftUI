//
//  ContentView.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/14/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Contact.entity(), sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ]) var contacts: FetchedResults<Contact>
    
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingAddContact = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout, spacing: 10) {
                    ForEach(self.contacts, id: \.self) { contact in
                        ContactLinkView(contact: contact)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text("Contacts"))
            .navigationBarItems(trailing: Button(action: {
                self.showingAddContact = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: self.$showingAddContact) {
                ContactAddView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
