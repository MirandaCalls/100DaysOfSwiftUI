//
//  Contact+CoreDataProperties.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/15/21.
//
//

import Foundation
import CoreData
import MapKit

extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageName: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var savedLocation: Bool

    var wrappedName: String {
        self.name ?? "Unknown name"
    }
    
    var wrappedImageName: String {
        self.imageName ?? ""
    }
    
    var imageUrl: URL {
        return FileManager.default.getDocumentsDirectory().appendingPathComponent(self.wrappedImageName)
    }
    
    var contactLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
    
}

extension Contact : Identifiable {

}
