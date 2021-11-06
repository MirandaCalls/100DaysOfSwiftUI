//
//  AddItemView.swift
//  iExpense
//
//  Created by Geoffrie Maiden Mueller on 11/4/21.
//

import SwiftUI

struct AddItemView: View {
    let AMOUNT_ERROR = "Value must be a number"
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    
    @State private var amount = ""
    @State private var amountInvalid = false
    
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
                
                VStack(alignment: .leading) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .onChange(of: amount, perform: validateAmount)
                    if amountInvalid {
                        Text(AMOUNT_ERROR)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
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
    
    func validateAmount(newValue: String) {
        amountInvalid = Double(self.amount) == nil
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(expenses: Expenses())
    }
}
