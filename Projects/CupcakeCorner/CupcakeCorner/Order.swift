//
//  Order.swift
//  CupcakeCorner
//
//  Created by Geoffrie Maiden Mueller on 11/17/21.
//

import Foundation

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var extraFrosting = false
    var addSprinkles = false
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        let name_invalid = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty;
        let address_invalid = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty;
        let city_invalid = city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty;
        let zip_invalid = zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty;
        
        if name_invalid || address_invalid || city_invalid || zip_invalid {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
