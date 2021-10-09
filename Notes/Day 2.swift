/**
 * Day 2
 * Collections
 * Values that let you store a group of values under a single value
 **/

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

// Arrays: Values must all be of a single type
// Most common
// Use when needed: Collection that can contain duplicates or order of items matters
// Store data in the order you add them
let beatles: [String] = [john, paul, george, ringo]
beatles[1]

// Sets: no item can appear twice in a set
// Use when needed: Collection of only unique values and be able to check quickly if a value is in it
// Any order
let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue"])

// Tuples: Several values together in a single value, fixed in size
// Can access in numerical position or by name
// Use when needed: Specific fixed collection of values with names
var name = (first: "Taylor", last: "Swift")
name.0
name.first
name.0 = "T"
var full_name = "\(name.first) \(name.last)"
var other = (1, 2, 3, 4)
other.3

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

// Can't add or remove items
// NOT ALLOWED: name.age = 9
// Can't change the type of items
// NOT ALLOWED: name.first = 9

// Dictionaries
// Collections of values like arrays
// Access values using a key
// Access values using anything you want
var heights: [String: Double] = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]
heights["Bruno Mars"] = 1.75

// Dictionary default values
// Accessing a key that doesn't exist results in a value of nil
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
favoriteIceCream["Paul"]
favoriteIceCream["Bruno", default: "Unknown"]

// Empty Collections

// Empty Dictionary
var teams = [String: String]()
teams["Paul"] = "Red"
var scores = Dictionary<String, Int>()

// Empty Array
var results = [Int]()
var results2 = Array<Int>()

// Empty Sets
var words = Set<String>()
var numbers = Set<Int>()

// Enumerations (enums)

// These three allow for spelling mistakes
let result = "failure"
let result2 = "failed"
let result3 = "fail"

// Useful to avoid spelling mistakes
enum Result {
    case success
    case failure
}

let result4 = Result.failure

// Enum associated values
// Attaching additional information to the enums
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

// Enum raw values
// Lets use give enums specific values to reference with
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 3)

