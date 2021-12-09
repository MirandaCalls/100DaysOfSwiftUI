//
//  WikipediaResult.swift
//  BucketList
//
//  Created by Geoffrie Maiden Mueller on 12/8/21.
//

import Foundation

struct WikiResult: Codable {
    let query: WikiQuery
}

struct WikiQuery: Codable {
    let pages: [Int: WikiPage]
}

struct WikiPage: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    static func < (lhs: WikiPage, rhs: WikiPage) -> Bool {
        lhs.title < rhs.title
    }
}
