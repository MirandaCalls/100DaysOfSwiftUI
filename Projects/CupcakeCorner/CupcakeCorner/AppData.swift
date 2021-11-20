//
//  AppData.swift
//  CupcakeCorner
//
//  Created by Geoffrie Maiden Mueller on 11/19/21.
//

import Foundation

class AppData: ObservableObject {
    
    @Published var order: Order
    
    init() {
        self.order = Order()
    }
}
