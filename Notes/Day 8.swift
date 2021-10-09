/**
 * Day 8
 * Structs, properties and methods
 */

// Basic struct
struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)
tennis.name = "Lawn Tennis"
print(tennis.name)

// Computed properties
struct SportV2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if (isOlympicSport) {
            return "\(name) is an Olympic sport."
        } else {
            return "\(name) is not an Olympic sport."
        }
    }
}

var halo = SportV2(name: "Halo E-Sports", isOlympicSport: false)
print(halo.olympicStatus)

// Property observers
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete.")
        }
    }
}

var load_mask = Progress(task: "Fetching data", amount: 20)
load_mask.amount = 40
load_mask.amount = 67
load_mask.amount = 99

// Methods
struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        population * 1000
    }
}

let London = City(population: 9_000_000)
London.collectTaxes()

// Mutating methods
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var Nathan = Person(name: "Nathan Fillion")
print("Celebrity: \(Nathan.name)")
Nathan.makeAnonymous()
print("Celebrity: \(Nathan.name)")

// Properties and methods of strings
let yoda = "Do or do not, there is no try."
print(yoda.count)
print(yoda.hasPrefix("Do"))
print(yoda.uppercased())
print(yoda.sorted())

// Properties and methods of arrays
var toys = ["Woody"]
print(toys.count)

// Add more items to array
toys.append("Buzz")
toys.firstIndex(of: "Buzz")

print(toys.sorted())
toys.remove(at: 1)

// Quiz tried getting younger star wars folks confused with the array index question
