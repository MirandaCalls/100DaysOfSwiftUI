//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Geoffrie Maiden Mueller on 10/18/21.
//

import SwiftUI

struct ContentView: View {
    let successResponses = ["Good job!", "Way to go!", "Keep it up!"]
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var totalQuestions = 1
    @State private var correctAnswers = 0
    
    @State private var showResultsAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var tappedFlag = 0

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
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("Tap the flag of \(countries[correctAnswer])"))
    
                    ForEach(0 ..< 3) { number in
                        FlagButton(
                            imageName: self.countries[number],
                            isActive: !showResultsAlert || tappedFlag == number
                        ) {
                            flagTapped(number)
                        }
                        .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                    }
                    
                    Text("Score: \(correctAnswers)/\(totalQuestions)")
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
                .transition(.scale)
            }
        }
        
        .alert(isPresented: $showResultsAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedFlag = number
        
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
            withAnimation {
                gameComplete = true
            }
            return
        }
        
        totalQuestions += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        gameComplete = false
        totalQuestions = 0
        correctAnswers = 0
        askQuestion()
    }
}

struct FlagButton: View {
    var imageName: String
    var isActive: Bool
    var action: () -> Void
    
    @State private var spinDegrees = 0.0
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                spinDegrees += 360
            }
            self.action()
        }) {
            Image(imageName)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
                .opacity(isActive ? 1 : 0.25)
                .animation(.default)
                .rotation3DEffect(.degrees(spinDegrees), axis: (x: 0, y: 1, z: 0))
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
