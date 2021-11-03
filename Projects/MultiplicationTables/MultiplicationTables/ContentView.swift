//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Geoffrie Maiden Mueller on 11/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var activeView = DisplayedView.Settings
    @State private var questions = [(factor1: Int, factor2: Int)]()
    @State private var answeredCorrectly = 0
    @State private var activeQuestion = 0
    @State private var missedQuestionIndices = [Int]()
    
    var body: some View {
        NavigationView {
            if activeView == DisplayedView.Settings {
                SettingsView() { settingsQuestions in
                    questions = settingsQuestions
                    activeView = DisplayedView.AskQuestion
                }
            } else if activeView == DisplayedView.AskQuestion {
                AskQuestionView(question: questions[activeQuestion]) { correct in
                    if correct {
                        answeredCorrectly += 1
                    } else {
                        missedQuestionIndices.append(activeQuestion)
                    }
                    
                    if activeQuestion + 1 == questions.count {
                        hideKeyboard()
                        activeView = DisplayedView.Results
                        return;
                    }
                    
                    activeQuestion += 1
                }
            } else {
                ResultsView(questions: self.questions, correctCount: answeredCorrectly, missedQuestionIndices: self.missedQuestionIndices) {
                    answeredCorrectly = 0
                    activeQuestion = 0
                    missedQuestionIndices = [Int]()
                    activeView = DisplayedView.Settings
                }
            }
        }
    }
}

enum DisplayedView {
    case Settings
    case AskQuestion
    case Results
}

struct SettingsView: View {
    var completeAction: ([(factor1: Int, factor2: Int)]) -> Void
    
    let questionAmounts = [5, 10, 25]
    
    @State private var practiceAllTables = false
    @State private var tableMaximum = 2
    @State private var selectedQAmount = 0
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select tables to practice:")
                        .font(.headline)
                    Toggle("Practice all", isOn: $practiceAllTables)
                    if !practiceAllTables {
                        Stepper(value: $tableMaximum, in: 2...12, step: 1) {
                            Text("Tables up to \(tableMaximum)")
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("How many questions:")
                        .font(.headline)
                    Picker("How many questions:", selection: $selectedQAmount) {
                        ForEach(0..<questionAmounts.count) {
                            Text("\(questionAmounts[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section {
                Button("Start") {
                    completeAction(generateQuestions())
                }
            }
        }
        .navigationBarTitle("Practice Multiplication")
    }
    
    func generateQuestions() -> [(factor1: Int, factor2: Int)] {
        var questions = [(factor1: Int, factor2: Int)]();
        
        let questions_count = questionAmounts[selectedQAmount];
        var max_table = 12;
        if !practiceAllTables {
            max_table = tableMaximum
        }
        
        for _ in 0..<questions_count {
            questions.append((
                factor1: Int.random(in: 1...12),
                factor2: Int.random(in: 1...max_table))
            )
        }
        
        return questions
    }
}

struct AskQuestionView: View {
    var question: (factor1: Int, factor2: Int)
    var completeAction: (Bool) -> Void
    
    @State private var input = ""
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 20) {
                Text("\(question.factor1)")
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.black, lineWidth: 2))
                
                Text("X")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("\(question.factor2)")
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.black, lineWidth: 2))
            }
            
            TextField("Your answer", text: $input)
            .keyboardType(.numberPad)
            .textFieldStyle(.roundedBorder)
            
            Button("Submit") {
                let correct = checkAnswer()
                input = ""
                completeAction(correct)
            }
        }
        .padding()
    }
    
    func checkAnswer() -> Bool {
        let answer = question.factor1 * question.factor2;
        let user_answer = Int(input) ?? 0
        return answer == user_answer
    }
}

struct ResultsView: View {
    var questions: [(factor1: Int, factor2: Int)]
    var correctCount: Int
    var missedQuestionIndices: [Int]
    var completeAction: () -> Void
    
    var body: some View {
        Form {
            Text("Answered \(correctCount) correctly out of \(questions.count)")
            
            if missedQuestionIndices.count != 0 {
                Section {
                    Text("You missed the following:")
                    List(0..<missedQuestionIndices.count) {
                        Text("\(formatEquation(question: questions[missedQuestionIndices[$0]]))")
                    }
                }

            }

            Section {
                Button("Restart") {
                    completeAction()
                }
            }
        }
        .navigationBarTitle("Your Grade")
    }
    
    func formatEquation(question: (factor1: Int, factor2: Int)) -> String {
        let answer = question.factor1 * question.factor2
        return "\(question.factor1) x \(question.factor2) = \(answer)"
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
