//
//  ContentView.swift
//  HabitTracker
//
//  Created by Geoffrie Maiden Mueller on 11/14/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habitData = HabitData(fromUserDefaults: true)
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List(habitData.getAllActivity()) { activity in
                NavigationLink(destination: SummarizeActivityView(
                    habitData: self.habitData,
                    activity: activity
                )) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(activity.habitName!)")
                            .font(.headline)
                        Text("\(activity.completedOnFormatted)")
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarItems(leading:
                NavigationLink(destination: SettingsView(data: self.habitData)) {
                    Image(systemName: "gear")
                }
            )
            .navigationBarItems(trailing:
                Button(action: {
                self.showingAddActivity = true
                }) {
                    HStack {
                        Image(systemName: "square.and.pencil")
                    }
                }
            )
            .navigationBarTitle("Habit History")
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivityView(habits: self.habitData.habits) { newActivity in
                let uuid = UUID().uuidString
                let activity = Habit.Activity(
                    id: uuid,
                    notes: newActivity.notes,
                    completedOn: Date()
                )
                self.habitData.addActivity(to: newActivity.habitId, activity: activity)
                self.habitData.save()
            }
        }
        .onAppear {
            if habitData.habits.count == 0 {
                habitData.habits = Bundle.main.decode("data.json")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let data = HabitData()
        data.habits = Bundle.main.decode("data.json")
        
        return ContentView(habitData: data)
    }
}
