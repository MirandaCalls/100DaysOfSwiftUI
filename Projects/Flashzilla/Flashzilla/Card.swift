//
//  Card.swift
//  Flashzilla
//
//  Created by Geoffrie Maiden Mueller on 12/25/21.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
