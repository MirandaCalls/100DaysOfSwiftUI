//
//  ClassMember.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import Foundation

struct ClassMember: Codable, Identifiable {
    var id: String
    var username: String
    var name: String
    var description: String
    var profileImageUrl: String
    var url: String
    var joinedAt: Date
    var friendIds: [String]
    
    var joinedAtFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM y"
        return formatter.string(from: self.joinedAt)
    }
}
