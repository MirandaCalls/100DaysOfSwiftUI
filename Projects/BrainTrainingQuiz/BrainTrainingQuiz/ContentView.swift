//
//  ContentView.swift
//  BrainTrainingQuiz
//
//  Created by Geoffrie Maiden Mueller on 10/23/21.
//

import SwiftUI

struct ContentView: View {
    let moves     = ["Rock",     "Paper",    "Scissors"]
    let winMoves  = ["Paper",    "Scissors", "Rock"    ]
    let loseMoves = ["Scissors", "Rock",     "Paper"   ]
    
    @State private var computerChoice = Int.random(in: 0 ..< 3)
    @State private var userShouldWin = Bool.random()
    @State private var turnNumber = 1
    @State private var userScore = 0
    
    @State private var showAnswerAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var gameComplete = false
    
    var body: some View {
        ZStack {
            Image("Background")
            if !gameComplete {
                QuizTurnDialog(
                    turnNumber: turnNumber,
                    userScore: userScore,
                    possibleMoves: moves,
                    computerMove: moves[computerChoice],
                    userShouldWin: userShouldWin
                ) {
                    adjustUserScore(move: $0)
                }
            } else {
                VStack(spacing: 40) {
                    VStack(spacing: 10) {
                        Text("Game Over")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.black)
                        Text("Your Score: \(userScore)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        restartQuiz()
                    }) {
                        Text("Play Again")
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 20)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                }
                .makeQuizWidget(width: 350, height: 200)
            }

        }
        
        .alert(isPresented: $showAnswerAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                advanceToNextTurn()
            })
        }
    }
    
    func adjustUserScore(move: String) {
        var correctChoice: String
        if userShouldWin {
            correctChoice = winMoves[computerChoice]
        } else {
            correctChoice = loseMoves[computerChoice]
        }
        
        if move == correctChoice {
            userScore += 1
            alertTitle = "Correct"
            alertMessage = "You have chosen wisely."
        } else {
            userScore -= 1
            alertTitle = "Incorrect"
            alertMessage = "You should have chosen \(correctChoice). Lose a point!"
        }
        
        showAnswerAlert = true
    }
    
    func advanceToNextTurn() {
        turnNumber += 1
        
        if (turnNumber > 10) {
            gameComplete = true
            return
        }
        
        randomizeQuestion()
    }
    
    func randomizeQuestion() {
        computerChoice = Int.random(in: 0 ..< 3)
        userShouldWin = Bool.random()
    }
    
    func restartQuiz() {
        turnNumber = 1
        userScore = 0
        randomizeQuestion()
        gameComplete = false
    }
}

struct QuizTurnDialog: View {
    var turnNumber = 0
    var userScore = 0
    var computerMove = ""
    var possibleMoves = [String]()
    var userShouldWin = false
    var buttonAction: (String) -> Void
    
    init(turnNumber: Int, userScore: Int, possibleMoves: [String], computerMove: String, userShouldWin: Bool, buttonAction: @escaping (String) -> Void) {
        self.turnNumber = turnNumber
        self.userScore = userScore
        self.possibleMoves = possibleMoves
        self.computerMove = computerMove
        self.userShouldWin = userShouldWin
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Turn \(turnNumber)/10")
                Spacer()
                Text("Score: \(userScore)")
            }
            .padding()
            .makeQuizWidget(width: 350, height: 50)
            VStack(spacing: 30) {
                VStack {
                    Text("Druid's Choice")
                        .font(.title)
                    QuizChoice(image: computerMove)
                }
                VStack {
                    Text("Tap the proper choice to")
                    Text(userShouldWin ? "WIN" : "LOSE")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                        .foregroundColor(userShouldWin ? Color.green : Color.red)
                }
                HStack(spacing: 20) {
                    ForEach(possibleMoves, id: \.self) { move in
                        Button(action: {
                            buttonAction(move)
                        }) {
                            QuizChoice(image: move)
                                .shadow(color: .yellow, radius: 4)
                        }
                    }
                }
            }
            .makeQuizWidget(width: 350, height: 400)
        }
    }
}

struct QuizChoice: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .padding(5)
            .background(RadialGradient(gradient: Gradient(colors: [.white, Color(red: 0.6, green: 0.4, blue: 0.2)]), center: .center, startRadius: 5, endRadius: 80))
            .frame(maxWidth: 80, maxHeight: 80)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.black, lineWidth: 1))
    }
}

struct QuizWidget: ViewModifier {
    var width: CGFloat?
    var height: CGFloat?
    
    func body(content: Content) -> some View {
        ZStack {
            Color.black
                .opacity(0.7)
                .cornerRadius(15)
            content
        }
        .foregroundColor(Color.white)
        .frame(width: width, height: height)
    }
}

extension View {
    func makeQuizWidget(width: CGFloat?, height: CGFloat?) -> some View {
        self.modifier(QuizWidget(width: width, height: height))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
