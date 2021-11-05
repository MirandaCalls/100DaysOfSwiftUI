//
//  AddItemView.swift
//  iExpense
//
//  Created by Geoffrie Maiden Mueller on 11/4/21.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    if let amount = Double(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: amount)
                        expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(expenses: Expenses())
    }
}
