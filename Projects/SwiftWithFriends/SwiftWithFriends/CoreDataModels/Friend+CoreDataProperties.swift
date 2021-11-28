//
//  Friend+CoreDataProperties.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/28/21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var classMember: ClassMember?

    var wrappedId: String {
        self.id ?? "No ID"
    }
}

extension Friend : Identifiable {

}
