//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Geoffrie Maiden Mueller on 12/27/21.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new card")) {
                    TextField("Prompt", text: self.$newPrompt)
                    TextField("Answer", text: self.$newAnswer)
                    Button("Add card", action: self.addCard)
                }
                
                Section {
                    ForEach(0..<self.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(self.cards[index].prompt)
                                .font(.headline)
                            Text(self.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: self.removeCards)
                }
            }
            .navigationBarTitle("Edit Cards")
            .navigationBarItems(trailing: Button("Done", action: self.dismiss))
            .listStyle(GroupedListStyle())
            .onAppear(perform: self.loadData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func addCard() {
        let trimmed_prompt = self.newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmed_answer = self.newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmed_prompt.isEmpty == false && trimmed_answer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmed_prompt, answer: trimmed_answer)
        self.cards.insert(card, at: 0)
        self.saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        self.cards.remove(atOffsets: offsets)
        self.saveData()
    }
}

struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
    }
}
