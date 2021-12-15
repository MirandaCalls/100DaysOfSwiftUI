//
//  Contact+CoreDataClass.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/14/21.
//
//

import SwiftUI
import CoreData

@objc(Contact)
public class Contact: NSManagedObject, Comparable {
    
    static public func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.wrappedName < rhs.wrappedName
    }
    
}
