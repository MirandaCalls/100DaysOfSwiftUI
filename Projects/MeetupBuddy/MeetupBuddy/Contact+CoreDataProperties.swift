//
//  Contact+CoreDataProperties.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/14/21.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?

    var wrappedName: String {
        self.name ?? "Unknown name"
    }
    
    var wrappedImageName: String {
        self.imageName ?? ""
    }
    
    var imageUrl: URL {
        return FileManager.default.getDocumentsDirectory().appendingPathComponent(self.wrappedImageName)
    }
    
}

extension Contact : Identifiable {

}
