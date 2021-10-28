//
//  ContentView.swift
//  WordScramble
//
//  Created by Geoffrie Maiden Mueller on 10/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func startGame() {
        if let allWordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let text = try? String(contentsOf: allWordsURL) {
                let all_words = text.components(separatedBy: "\n")
                rootWord = all_words.randomElement() ?? "serenity"
                return
            }
        }
        
        fatalError("Unable to load words.txt!")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You must build a word only from the root word's letters")
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
