//
//  Habit.swift
//  HabitTracker
//
//  Created by Geoffrie Maiden Mueller on 11/14/21.
//

import Foundation

struct Habit: Codable, Identifiable {
    struct Activity: Codable, Identifiable {
        var id: String
        var notes: String
        var completedOn: Date
        
        var completedOnFormatted: String {
            var formatted = ""
            
            var formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            formatted += formatter.string(from: completedOn)
            
            formatter = DateFormatter()
            formatter.dateStyle = .short
            formatted += " on " + formatter.string(from: completedOn)
            
            return formatted
        }
        
        var habitName: String?
    }
    
    var id: String
    var name: String
    var description: String
    var activities: [Activity]
}

class HabitData: ObservableObject {
    @Published var habits: [Habit]
    
    init(fromUserDefaults: Bool = false) {
        self.habits = [Habit]()
        
        if fromUserDefaults {
            if let habits = UserDefaults.standard.data(forKey: "Habits") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([Habit].self, from: habits) {
                    self.habits = decoded
                    return
                }
            }
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.habits) {
            UserDefaults.standard.set(encoded, forKey: "Habits")
        }
    }
    
    func getAllActivity() -> [Habit.Activity] {
        var activities = [Habit.Activity]();
        for habit in self.habits {
            for activity in habit.activities {
                var copy = activity;
                copy.habitName = habit.name
                activities.append(copy)
            }
        }
        
        activities = activities.sorted {
            $0.completedOn > $1.completedOn
        }
        
        return activities
    }
    
    func addActivity(to habitId: String, activity: Habit.Activity) {
        guard let habitIndex = self.findHabitIndexBy(id: habitId) else {
            return
        }
        
        self.habits[habitIndex].activities.append(activity)
    }
    
    func findHabitIndexBy(id: String) -> Int? {
        for (index, habit) in self.habits.enumerated() {
            if habit.id == id {
                return index
            }
        }
        
        return nil
    }
    
    func findHabitIndexBy(name: String) -> Int? {
        for (index, habit) in self.habits.enumerated() {
            if habit.name == name {
                return index
            }
        }
        
        return nil
    }
}
