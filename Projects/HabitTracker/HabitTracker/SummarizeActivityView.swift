//
//  SummarizeActivityView.swift
//  HabitTracker
//
//  Created by Geoffrie Maiden Mueller on 11/14/21.
//

import SwiftUI

struct SummarizeActivityView: View {
    @ObservedObject var habitData: HabitData
    var activity: Habit.Activity
    
    var body: some View {
        let habitIndex = habitData.findHabitIndexBy(name: self.activity.habitName!)!
        let habit = self.habitData.habits[habitIndex]
        
        return VStack(alignment: .leading) {
            Text("\(self.activity.completedOnFormatted)")
                .font(.title2)
            Text("Notes")
                .font(.headline)
            Text("\(self.activity.notes)")
                .padding([.leading])
            
            Divider()
            
            Text("\(habit.name)")
                .font(.title2)
            Text("\(habit.description)")
                .font(.caption)
            Text("You've completed this habit \(habit.activities.count) times!")
                .padding([.top])
        
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationBarTitle("Activity Log", displayMode: .inline)
    }
}

struct SummarizeActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let habit_data = HabitData()
        habit_data.habits = Bundle.main.decode("data.json")
        var activity = habit_data.habits[0].activities[0]
        activity.habitName = habit_data.habits[0].name
        
        return SummarizeActivityView(
            habitData: habit_data,
            activity: activity
        )
    }
}
