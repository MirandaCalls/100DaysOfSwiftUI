//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Geoffrie Maiden Mueller on 10/18/21.
//

import SwiftUI

struct ContentView: View {
    let successResponses = ["Good job!", "Way to go!", "Keep it up!"]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var totalQuestions = 1
    @State private var correctAnswers = 0
    @State private var scoreText = ""
    
    @State private var showResultsAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    @State private var gameComplete = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            if !gameComplete {
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            flagTapped(number)
                        }) {
                            FlagImage(imageName: self.countries[number])
                        }
                    }
                    
                    Text(scoreText)
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }
            } else {
                VStack(spacing: 50) {
                    VStack(spacing: 10) {
                        Text("Final Score")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.black)
                        Text("\(correctAnswers) / \(totalQuestions) correct")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        restartGame()
                    }) {
                        Text("Play Again")
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 20)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                }
            }
        }
        
        .alert(isPresented: $showResultsAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            alertTitle = "Correct"
            alertMessage = successResponses.randomElement() ?? successResponses[0]
            correctAnswers += 1
        } else {
            alertTitle = "Wrong"
            alertMessage = "You chose the flag of \(countries[number])."
        }
        
        showResultsAlert = true
    }
    
    func askQuestion() {
        if (totalQuestions == 10) {
            gameComplete = true
            return
        }
        
        if totalQuestions != 0 {
            scoreText = "Score: \(correctAnswers)/\(totalQuestions)"
        }
        
        totalQuestions += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        gameComplete = false
        scoreText = ""
        totalQuestions = 0
        correctAnswers = 0
        askQuestion()
    }
}

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
