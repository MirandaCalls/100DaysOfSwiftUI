import SwiftUI
import PlaygroundSupport

struct BasicList: View {
    var body: some View {
        List {
            Section(header: Text("Section 1")) {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section(header: Text("Section 2")) {
                ForEach(0 ..< 5) {
                    Text("Dynamic row \($0)")
                }
            }

            Section(header: Text("Section 3")) {
                Text("Static row 3")
            }
        }
        .listStyle(.grouped)
    }
}

struct DynamicList: View {
    let names = ["Finn", "Rey", "Poe", "Kylo Supreme"]
    
    var body: some View {
        List(names, id: \.self) {
            Text("\($0)")
        }
    }
}

struct LoadTextFile: View {
    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let text = try? String(contentsOf: fileURL) {
                Text(text)
            }
        } else {
            Text("No bueno")
        }
    }
}

struct StringsAndSpellcheck: View {
    var body: some View {
        let input =
"""
You're on the phone with your girlfriend, she's upset,
She's going off about something that you said,
Cause she doesn't get your humor like I do
"""
        let lyrics = input.components(separatedBy: "\n")
        
        VStack {
            List(lyrics, id: \.self) {
                Text("\($0)")
            }
        }
    }
    
    func workingWithStrings() -> String {
        let input = """
                    a
                    b
                    c
                    """
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmed ?? "Error"
    }
    
    func spellcheckWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}


PlaygroundPage.current.setLiveView(BasicList())
