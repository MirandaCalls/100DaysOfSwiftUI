//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Geoffrie Maiden Mueller on 11/14/21.
//

import SwiftUI

struct AddHabitView: View {
    var saveAction: ((name: String, description: String)) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var tfName = ""
    @State private var tfDescription = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                VStack {
                    HStack {
                        TextField("Name", text: $tfName)
                    }
                    Divider()
                    TextField("Description", text: $tfDescription)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("New Habit", displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
            .navigationBarItems(trailing:
                Button("Save") {
                    if tfName != "" {
                        self.saveAction((name: self.tfName, description: self.tfDescription))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView() { newHabit in
            print("Finished")
        }
    }
}
