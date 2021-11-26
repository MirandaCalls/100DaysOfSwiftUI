//
//  Candy+CoreDataProperties.swift
//  CoreDataTechniques
//
//  Created by Geoffrie Maiden Mueller on 11/25/21.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    var wrappedName: String {
        name ?? "Unknown candy"
    }

}

extension Candy : Identifiable {

}
