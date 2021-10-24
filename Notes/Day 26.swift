import SwiftUI
import PlaygroundSupport

struct StepperDemo: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%G") hours")
        }
    }
}

struct DateTimePickingDemo: View {
    @State private var wakeUp = Date()
    
    var body: some View {
        let now = Date()
        let tomorrow = Date().addingTimeInterval(86400)
        let range = now ... tomorrow
        
        Form {
            DatePicker("Please enter a date", selection: $wakeUp, in: range, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
        }
    }
}

struct DateComponentsDemo: View {
    var body: some View {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        // Creating a date from specific time, but not caring about the date
        let date = Calendar.current.date(from: components) ?? Date()
        
        // Getting specific date attributes out of a Date object
        components = Calendar.current.dateComponents([.hour, .minute], from: date)
        var hour = components.hour ?? 0
        var minutes = components.minute ?? 0
        
        // Formatting a Date to display it to users
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let date_string = formatter.string(from: date)
        
        return Form {
            Text(date_string)
        }
    }
}

PlaygroundPage.current.setLiveView(DateTimePickingDemo())
