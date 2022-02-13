//
//  ClassMemberDto.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/28/21.
//

import Foundation

/**
 * Class used purely for decoding from JSON received from server
 */
struct ClassMemberDto: Codable {
    var twitterId: Int
    var name: String
    var username: String
    var description: String
    var profileImageUrl: String
    var url: String
    var joinedAt: Date
    var friendIds: [Int]
}
