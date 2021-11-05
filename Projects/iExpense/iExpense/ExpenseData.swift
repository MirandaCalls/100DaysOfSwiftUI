//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Geoffrie Maiden Mueller on 11/4/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
