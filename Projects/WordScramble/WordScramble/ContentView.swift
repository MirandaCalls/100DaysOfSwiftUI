//
//  ContentView.swift
//  WordScramble
//
//  Created by Geoffrie Maiden Mueller on 10/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var allWords = [String]()
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var score: Int {
        var total = usedWords.count
        for word in usedWords {
            total += word.count
        }
        return total
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(score)")
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .font(.title2)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
                
                GeometryReader { listGeo in
                    List {
                        ForEach(0..<self.usedWords.count) { index in
                            GeometryReader { geo in
                                HStack {
                                    Image(systemName: "\(self.usedWords[index].count).circle")
                                        .foregroundColor(Color(
                                            red: self.calculateWordCountColor(listGeo: listGeo, rowGeo: geo),
                                            green: 0.6,
                                            blue: 0.8
                                        ))
                                    Text(self.usedWords[index])
                                }
                                .offset(x: self.calculateWordOffset(listGeo: listGeo, rowGeo: geo), y: 0)
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("\(self.usedWords[index]), \(self.usedWords[index].count) letters"))
                            }
                        }
                    }
                }
                .coordinateSpace(name: "ListArea")
                
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .autocapitalization(.none)

            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: refreshGame) {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
        }
    }
    
    func calculateWordCountColor(listGeo: GeometryProxy, rowGeo: GeometryProxy) -> Double {
        print(listGeo.size.height)
        let color = rowGeo.frame(in: .named("ListArea")).minY / (listGeo.size.height * 1.4)
        if color > 1 {
            return 1
        }
        
        return color
    }
    
    func calculateWordOffset(listGeo: GeometryProxy, rowGeo: GeometryProxy) -> CGFloat {
        let offset = rowGeo.frame(in: .named("ListArea")).minY - listGeo.size.height
        if offset < 0 {
            return 0
        }
        
        return offset / 2
    }
    
    func startGame() {
        if let allWordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let text = try? String(contentsOf: allWordsURL) {
                let all_words = text.components(separatedBy: "\n")
                allWords = all_words
                refreshGame()
                return
            }
        }
        
        fatalError("Unable to load words.txt!")
    }
    
    func refreshGame() {
        rootWord = allWords.randomElement() ?? "serenity"
        usedWords = [String]()
        newWord = ""
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Word not allowed", message: "You cannot use the original word as an answer.")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not allowed", message: "You must build a 3-letter or longer word using the given letters.")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word doesn't exist", message: "You can't make words up!")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word);
    }
    
    func isPossible(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        
        var temp_word = rootWord
        for letter in word {
            if let pos = temp_word.firstIndex(of: letter) {
                temp_word.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelled_range = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelled_range.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
