//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Geoffrie Maiden Mueller on 11/14/21.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var habits: [Habit]
    var saveAction: ((habitId: String, notes: String)) -> Void
    
    @State private var selectedHabit = ""
    @State private var notes = "N/A"
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Habit", selection: $selectedHabit) {
                    ForEach(self.habits) { habit in
                        Text("\(habit.name)")
                    }
                }
                
                Section(header: Text("Your Notes")) {
                    TextEditor(text: $notes)
                }
            }
            .navigationBarTitle("Add Activity", displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
            .navigationBarItems(trailing:
                Button("Save") {
                    if selectedHabit != "" {
                        self.saveAction((
                            habitId: self.selectedHabit,
                            notes: self.notes
                        ))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let habits: [Habit] = Bundle.main.decode("data.json")
        return AddActivityView(habits: habits) { newActivity in
            print("Finished")
        }
    }
}
