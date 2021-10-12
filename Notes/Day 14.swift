/**
 * Day 14
 * Review Day 2 (Swift Fundamentals)
 */

import Foundation

// Functions

// Function parameters can take 2 names.
// 1 for outside the function, 2 inside the function

// "is" outside, "album" inside
func favoriteAlbum(is album: String) {
    print("My favorite is \(album)")
}
favoriteAlbum(is: "Fearless")

// Functions have no limit on how many parameters they can take
// BUT, it is a code smell that function is doing too much if there is a large amount of parameters
func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year).")
}
printAlbumRelease(name: "Fearless (Taylor's version)", year: 2021)

// You can redact names from functions with an underscore
func buyMovie(_ movie: String) {
    print("\(movie) costs $19.99")
}
buyMovie("Serenity")

// Return values from a function
func albumIsTaylors(name: String) -> Bool {
    if name == "Taylor Swift" {
        return true
    } else if name == "Fearless" {
        return true
    }
    
    return false
}

if albumIsTaylors(name: "Taylor Swift") {
    print("That's one of hers!")
} else {
    print("Who made that?")
}

// Optionals

// 'nil': represents the abscense of a value 
// Using '?' after a typehint means that it can either be the value or 'nil'
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    }
    
    return "Hate"
}

var status: String?
status = getHaterStatus(weather: "rainy")

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

// Optional unwrapping
if let unwrapped_status = status {
    // Non-optional string can be used here
    takeHaterAction(status: unwrapped_status)
} else {
    // Handle the case if 'nil' was passed
}

// Force unwrapping
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" {
        return 2006
    } else if name == "Fearless" {
        return 2008
    }
    
    return nil
}

var year = yearAlbumReleased(name: "Taylor Swift")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}

// Implicitly unwrapped optionals

// Don't need to explicitly unwrap this variable to use it
// WARNING: If it is nil, it will crash the program when used wrongly
var name: String! = "Sophie"

// Optional chaining
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    default: return nil
    }
}

var album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")

// nil coalescing operator
let next_album = albumReleased(year: 434232) ?? "no more albums were made"
print(next_album)

let another_album = albumReleased(year: 2008) ?? "unknown"
print("The album is \(another_album)")

// Enumerations (enums)
enum WeatherType {
    // Attaching values to enums 
    case sun
    case cloud
    case rain 
    case wind(speed: Int)
    case snow
}

func getHaterStatus2(weather: WeatherType) -> String? {
    switch weather {
    // Switch cases execute top to the bottom, case by case till conditional is matched
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus2(weather: WeatherType.cloud)
getHaterStatus2(weather: .sun)

// Structs
// These are value types
struct Person {
    // memberwise initializer made automatically as long as no init() is defined
    
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

print(taylor.clothes)
print(other.shoes)

// Making copies of a struct
var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

taylor.describe()

// Classes
// Reference types
class PersonV2 {
    var clothes: String
    var shoes: String
    
    // Don't use 'func' before init
    // Swift requires that all non-optionals get a value before the end of init
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}

// Class inheritance
class Singer {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // objc allows older objective swift code to call this function
    @objc func sing() {
        print("La la la la")
    }
}

// Class inheritance
// Structs can't do this
class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

class HeavyMetalSinger: Singer {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }

    override func sing() {
        print("Grrrr rargh rargh rarrrrrgh!")
    }
}

var tswift = CountrySinger(name: "Taylor", age: 25)
tswift.name
tswift.age
tswift.sing()

