//
//  ContentView.swift
//  Flashzilla
//
//  Created by Geoffrie Maiden Mueller on 12/23/21.
//

import SwiftUI
import Subsonic

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var reshuffleFailures = false
    
    @State private var isActive = true
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showingEditScreen = false
    @State private var showingSettingsScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(.black)
                            .opacity(0.75)
                    )
                
                if self.timeRemaining > 0 {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: self.cards[index]) { success in
                                withAnimation {
                                    self.removeCard(at: index, success: success)
                                }
                            }
                            .stacked(at: index, in: self.cards.count)
                            .allowsHitTesting(index == self.cards.count - 1)
                            .accessibility(hidden: index < self.cards.count - 1)
                        }
                    }
                    .allowsHitTesting(self.timeRemaining > 0)
                }
                
                if self.cards.isEmpty || self.timeRemaining == 0 {
                    if !self.cards.isEmpty {
                        ZStack(alignment: .bottom) {
                            Image("hudsonaliens")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 400)
                                .cornerRadius(10)
                            
                            Text("Remaining cards: \(self.cards.count)")
                                .font(.title2)
                                .padding(5)
                                .foregroundColor(.white)
                                .background(.black.opacity(0.75))
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                        .transition(.slide)
                        .onAppear {
                            play(sound: "gameover.mp3")
                        }
                    }
                    
                    Button("Start Again", action: self.resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        self.showingSettingsScreen = true
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if self.differentiateWithoutColor || self.accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.removeCard(at: self.cards.count - 1, success: false)
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        
                        Button(action: {
                            self.removeCard(at: self.cards.count - 1, success: true)
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            
            if self.timeRemaining > 0 {
                withAnimation {
                    self.timeRemaining -= 1
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty {
                return
            }
            
            self.isActive = true
        }
        .sheet(isPresented: self.$showingEditScreen, onDismiss: self.resetCards) {
            EditCardsView()
        }
        .sheet(isPresented: self.$showingSettingsScreen, onDismiss: self.resetCards) {
            SettingsView()
        }
        .onAppear(perform: self.resetCards)
    }
    
    func removeCard(at index: Int, success: Bool) {
        guard index >= 0 else { return }
        
        let removed_card = self.cards[index]
        self.cards.remove(at: index)
        
        var reinserted_card = false
        if self.reshuffleFailures && success == false {
            reinserted_card = true
            
            // Got stuck with my interface freezing up when inserting the removed card to the back of the list
            // This seems to be the only solution I can find
            // https://www.hackingwithswift.com/forums/100-days-of-swiftui/day-91-flashzilla-challenges-can-t-seem-to-readd-a-card-successfully/2037
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards.insert(removed_card, at: 0)
            }
        }
        
        if self.cards.isEmpty && reinserted_card == false {
            self.isActive = false
        }
    }
    
    func resetCards() {
        self.loadData()
        self.timeRemaining = 10
        self.isActive = true
    }
    
    func loadData() {
        self.reshuffleFailures = UserDefaults.standard.bool(forKey: "reshuffleFailures")
        
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
