import SwiftUI
import PlaygroundSupport

struct User: Codable {
    // Codable allows this struct to be converted to plain text version
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct StructAsState: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your full name is \(user.firstName) \(user.lastName)")
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

class Employee: ObservableObject {
    @Published var firstName = "Code"
    @Published var lastName = "Monkey"
}

struct ObjectAsState: View {
    @ObservedObject private var user = Employee()
    
    var body: some View {
        VStack {
            Text("Your full name is \(user.firstName) \(user.lastName)")
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

struct NameView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    var body: some View {
        VStack {
            Text("Hello \(name)")
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ViewsInASheet: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            NameView(name: "@mirandacalls")
        }
    }
}

struct DeleteRows: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct StoringUserPreferences: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "tapCount")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "tapCount")
        }
    }
}

struct EncodingAsJSON: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    @State private var encoded = ""
    
    var body: some View {
        VStack {
            Text("Data: \(encoded)")
            Button("Save User") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user) {
                    encoded = String(data: data, encoding: String.Encoding.utf8) ?? ""
                }
            }
        }
    }
}

PlaygroundPage.current.setLiveView(EncodingAsJSON())
