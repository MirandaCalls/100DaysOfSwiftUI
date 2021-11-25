//
//  Movie+CoreDataProperties.swift
//  CoreDataTechniques
//
//  Created by Geoffrie Maiden Mueller on 11/24/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    var wrappedTitle: String {
        self.title ?? "Unknown title"
    }
    
    var wrappedDirector: String {
        self.director ?? "Unknown director"
    }

}

extension Movie : Identifiable {

}
