/**
 * Day 15
 * Review 3 (Swift Fundamentals)
 **/

import UIKit

// Property Observers
struct Person {
    var clothes: String {
        // Observers
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
    
    var age: Int
    var ageInDogYears: Int {
        // Computed Properties
        get {
            return age * 7
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts", age: 25)
taylor.clothes = "short skirts"
print(taylor.ageInDogYears)

// Static Properties & Methods
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"
    
    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)

// Access Control
// Public: Everyone can read and write the property
// Internal: Only your swift code can read and write the property
// File Private: Only swift code in the same file as the type can read and write the property
// Private: Most restrictive, only available inside methods that belong to the type or its extensions
class TaylorFan2 {
    private var name: String?
}

// Polymorphism
class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studio")
var fearless = StudioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")
var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

// Typecasting
for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
    
    // forced typecasting as!
}

// Typecasting for simple types
let number = 5
let text = String(number)
print(text)

// Closures
let vw = UIView()
UIView.animate(withDuration: 0.5) {
    // Trailing closure syntax
    vw.alpha = 0
}
