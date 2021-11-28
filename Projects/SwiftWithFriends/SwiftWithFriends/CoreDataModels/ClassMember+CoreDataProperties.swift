//
//  ClassMember+CoreDataProperties.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/28/21.
//
//

import Foundation
import CoreData


extension ClassMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassMember> {
        return NSFetchRequest<ClassMember>(entityName: "ClassMember")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var bio: String?
    @NSManaged public var profileImageUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var joinedAt: Date?
    @NSManaged public var friends: NSSet?
    
    var wrappedName: String {
        self.name ?? "Unknown name"
    }
    
    var wrappedUsername: String {
        self.username ?? "Unknown username"
    }
    
    var wrappedBio: String {
        self.bio ?? "No bio"
    }
    
    var wrappedProfileImageUrl: String {
        self.profileImageUrl ?? ""
    }
    
    var joinedAtFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM y"
        return formatter.string(from: self.joinedAt ?? Date())
    }
    
    var friendIds: [String] {
        let set = friends as? Set<Friend> ?? []
        
        return set.map {
            $0.wrappedId
        }
    }
    
}

// MARK: Generated accessors for friends
extension ClassMember {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension ClassMember : Identifiable {

}
