/**
 * Day 81
 * Context Menus, Local Notifications, Third Party Packages
 **/

import SwiftUI
import UserNotifications

struct ContextMenuDemo: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello world!")
                .padding()
                .background(self.backgroundColor)
            
            Text("Change color")
                .padding()
                // Press & hold menu
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = Color.red
                    }) {
                        // Don't try to use color in context menus
                        // SwiftUI will remove all color from any image
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                    }
                    
                    Button("Green") {
                        self.backgroundColor = Color.green
                    }
                    
                    Button("Blue") {
                        self.backgroundColor = Color.blue
                    }
                }
        }
    }
}

struct LocalNotificationDemo: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Notifications enabled!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "She looks hungry"
                content.sound = UNNotificationSound.default
                
                // Send notification 5 seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

// https://github.com/twostraws/SamplePackage
import SamplePackage

struct ThirdPartyPackageDemo: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
    	// .random(Int) is a function added to types that implement Sequence protocol
    	// from the SamplePackage third party library
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}
