/**
 * Day 68
 * Comparable Protocol, Documents Directory, View State with Enums
 */

import PlaygroundSupport
import SwiftUI

// Comparable conformance allows you to define how a particular
// struct will get sorted by functions like .sorted() which rely on Comparable
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    // Returns true if the left-hand side (lhs) should come before the right-hand side
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ComparableDemo: View {
    let users = [
        User(firstName: "Jack", lastName: "O'Neill"),
        User(firstName: "Daniel", lastName: "Jackson"),
        User(firstName: "Eli", lastName: "Wallace"),
        User(firstName: "Samantha", lastName: "Carter")
    ].sorted()
    
    var body: some View {
        List(self.users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

extension FileManager {
    /**
     * Returns location of the file-system documents folder for the app. This directory is generated
     * by the device and is not guaranteed to be the same path on two different devices.
     */
    func getDocumentsDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct DocumentsDirectoryDemo: View {
    var body: some View {
        Text("Tap to test documents directory")
            .onTapGesture {
                let str = "Test message, saved to documents directory"
                let url = FileManager.default.getDocumentsDirectory()
                    .appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed!")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

// Tracking which view should be displayed by a single enum value
struct ViewStatesWithEnums: View {
    enum LoadingState {
        case Loading, Failed, Success
    }
    
    var loadingState = LoadingState.Loading
    
    var body: some View {
        Group {
            if self.loadingState == LoadingState.Loading {
                LoadingView()
            } else if self.loadingState == LoadingState.Failed {
                FailedView()
            } else if self.loadingState == LoadingState.Success {
                SuccessView()
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ViewStatesWithEnums())
