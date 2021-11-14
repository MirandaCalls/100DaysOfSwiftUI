//
//  ManageHabitsView.swift
//  HabitTracker
//
//  Created by Geoffrie Maiden Mueller on 11/14/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var data: HabitData
    
    @State private var showingAddHabit = false
    
    var body: some View {
        Form {
            Section(header: Text("My Habits")) {
                List(data.habits) { habit in
                    VStack(alignment: .leading) {
                        Text("\(habit.name)")
                        if habit.description != "" {
                            Text("\(habit.description )")
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                showingAddHabit = true
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView() { newHabit in
                let uuid = UUID().uuidString
                let habit = Habit(
                    id: uuid,
                    name: newHabit.name,
                    description: newHabit.description,
                    activities: [Habit.Activity]()
                )
                
                data.habits.append(habit)
                self.data.save()
            }
        }
    }
}

struct ManageHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        let data = HabitData()
        data.habits = Bundle.main.decode("data.json")
        return SettingsView(data: data)
    }
}
