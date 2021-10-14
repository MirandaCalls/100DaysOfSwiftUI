/**
 * Day 16
 * Simple Swift UI views
 */

import SwiftUI
import PlaygroundSupport

// Basic list view
struct ListView: View {
    var body: some View {
        // Navigation views nest scrolling content within and handle switching pages
        NavigationView {
            Form {
                // There is a limit to 10 items inside a parent element
                
                // Using more than ten elements requires using sections or groups to further divide the content
                Section {
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
                Group {
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
            }
            
            // Call a function within this closure to set the title of the page
            .navigationBarTitle(Text("Swift UI"))
        }
    }
}

// View that demonstrates storing simple state
struct TapButtonView: View {
    // @State allows the value to be used and updated by any views
    @State private var tapCount = 0
    
    var body: some View {
        Form {
            Button("Tap count: \(tapCount)") {
                self.tapCount += 1
            }
        }
    }
}

// View that shows writing to stored state
struct EnterNameView: View {
    // Two way binding
    // Allows the property to be both written and read
    @State private var name = ""
    
    var body: some View {
        Form {
            // $ enables the two way binding
            TextField("Enter your name", text: $name)
            Text("Your name is \(name)")
        }
    }
}

// Simple Picker View
struct PickStudentView: View {
    // Data that we don't expose to any view
    // So it doesn't use @State
    let students = ["Harry", "Hermione", "Ron"]
    
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        // Pickers require a navigation view to move to a sub-page with the list of options
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    // ForEach is a view that lets you specify a loop amount
                    // and it will call the closure you provide for each item of the range
                    ForEach(0 ..< students.count) {
                        Text(self.students[$0])
                    }
                }
            }
            .navigationBarTitle(Text("Swift UI"))
        }
    }
}

PlaygroundPage.current.setLiveView(PickStudentView())
