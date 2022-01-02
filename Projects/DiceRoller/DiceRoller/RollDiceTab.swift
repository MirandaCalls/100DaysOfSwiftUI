//
//  RollDiceTab.swift
//  DiceRoller
//
//  Created by Geoffrie Maiden Mueller on 1/1/22.
//

import SwiftUI
import Subsonic

struct RollDiceTab: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var amount = 6
    @State private var dice = [6, 6, 6, 6, 6, 6]
    
    @State private var controlsDisabled = false
    @State private var finishRollingTime = Date()
    @State private var delay: Double = 0
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("WoodTexture")
                        .resizable()
                        .scaledToFill()
                    
                    LazyHGrid(rows: layout, spacing: 20) {
                        ForEach(0..<self.dice.count, id: \.self) { index in
                            Image(systemName: "die.face.\(self.dice[index]).fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white, .blue)
                                .frame(width: 100)
                                .shadow(radius: 5)
                        }
                    }
                    .frame(height: 250)
                }
                
                Stepper("Amount: \(self.amount) \(self.amount > 1 ? "dice" : "die")", value: self.$amount, in: 1...6)
                    .onChange(of: self.amount) { newValue in
                        self.adjustDiceAmount(newAmount: newValue)
                    }
                    .disabled(self.controlsDisabled)
                
                Button("Roll", action: {
                    play(sound: "DiceRolling.m4a")
                    self.controlsDisabled = true
                    self.delay = 0
                    
                    var deadline = Date()
                    deadline.addTimeInterval(TimeInterval(1))
                    self.finishRollingTime = deadline
                    
                    self.rollDice()
                })
                .buttonStyle(LargeButton())
                .font(.headline)
                .disabled(self.controlsDisabled)
            }
            .padding()
            .navigationBarTitle("Roll Dice")
        }
        
    }
    
    func adjustDiceAmount(newAmount: Int) {
        let adjustment_amount = newAmount - self.dice.count
        if adjustment_amount > 0 {
            for _ in 1...adjustment_amount {
                self.dice.append(6)
            }
        } else if adjustment_amount < 0 {
            let removal_amount = abs(adjustment_amount)
            for _ in 1...removal_amount {
                self.dice.removeLast()
            }
        }
    }
    
    func rollDice() {
        self.delay += 0.005
        
        var results = [Int]()
        for _ in 1...amount {
            let roll = Int.random(in: 1...6)
            results.append(roll)
        }
        self.dice = results

        if Date.now >= self.finishRollingTime {
            self.saveResult()
            self.controlsDisabled = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
            self.rollDice()
        }
    }
    
    func saveResult() {
        let result = RollResult(context: self.moc)
        result.id = UUID()
        result.rolledAt = Date.now
        result.values = self.dice.compactMap(String.init).joined(separator: " ")
        try? self.moc.save()
    }
}

struct LargeButton: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(5)
            .opacity(isEnabled ? 1 : 0.6)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}

struct RollDiceTab_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceTab()
    }
}
