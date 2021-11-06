//
//  ContentView.swift
//  iExpense
//
//  Created by Geoffrie Maiden Mueller on 11/3/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        HStack(spacing: 5) {
                            if item.amount >= 10 {
                                generateWarning(for: item.amount)
                            }
                            
                            let locale = Locale.current
                            let currencySymbol = locale.currencySymbol!
                            Text("\(currencySymbol)\(item.amount, specifier: "%G")")
                        }
                        
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddItemView(expenses: self.expenses)
        }
    }
    
    func generateWarning(for amount: Double) -> some View {
        Image(systemName: "exclamationmark.circle")
            .foregroundColor(.white)
            .padding(5)
            .background(amount < 100 ? Color.yellow : Color.red)
            .cornerRadius(10)
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
