//
//  Contact+CoreDataClass.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/15/21.
//
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {

    static public func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.wrappedName < rhs.wrappedName
    }
    
}
