//
//  RollResult+CoreDataProperties.swift
//  DiceRoller
//
//  Created by Geoffrie Maiden Mueller on 1/1/22.
//
//

import Foundation
import CoreData


extension RollResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RollResult> {
        return NSFetchRequest<RollResult>(entityName: "RollResult")
    }

    @NSManaged public var values: String?
    @NSManaged public var rolledAt: Date?
    @NSManaged public var id: UUID?
    
    var valuesWrapped: String {
        values ?? ""
    }
    
    var valuesArray: [Int] {
        let value_list = self.valuesWrapped.components(separatedBy: " ")
        return value_list.compactMap(Int.init)
    }
    
    var rolledAtWrapped: Date {
        rolledAt ?? Date()
    }
    
    var rolledAtFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        return formatter.string(from: self.rolledAtWrapped)
    }
    
}

extension RollResult : Identifiable {

}
