/**
 * Day 13
 * Consolidation 1 (Swift Fundamentals)
 **/

// Variables and constants

// var: Variable - value that can be reassigned and/or change
var name = "Nathan Fillion"
name = "Adam Baldwin"

// let: Constant - value assigned once that never changes
let spaceship = "Serenity"
// NOT ALLOWED: spaceship = "Enterprise"

// Types of Data

// Initialize a variable with a type annotation
var Jayne: String
var age: Int
var latitude: Double
var longitude: Float
var stay_out_too_late: Bool

// String, NOT ALLOWED Jayne = 25
Jayne = "The Hero of Canton"
// Int
age = 25
// Float/Double
latitude = 36.166667
longitude = -123486.783333
// Boolean
stay_out_too_late = true

// Type inference, Swift understanding what type you mean for a variable by what value you use

// Operators
var a: Double = 10
a = a + 1
a = a - 1
a = a * a

var b: Double = 10
b += 10
b -= 10
b *= 10

var names = name + " and Nathan Fillion"

// Modulus %
// Divide lefthand evenly by the right and return the remainder
let remainder = 10 % 3

// Comparisons
a = 1.1
b = 2.2
var c = a + b

c > 3
c >= 3
c > 4
c < 4

names == "Patrick Stewart and William Shatner"
names != "Patrick Stewart and William Shatner"

!stay_out_too_late

// String interpolation
var captions = "The current onscreen actor is " + name
print("The current onscreen actor is \(name)")

"Your name is \(name), your age is \(age), and your latitude is \(latitude)"
"Your age is \(age). In another \(age) years you will be \(age * 2)"

// Arrays
var even_numbers = [2, 4, 6, 8]
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]

songs[0]
songs[1]
songs[2]
// Will crash if you try accessing songs[3]

type(of: songs) // Array<String>

// Hold any type in an array
var anything: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

// Creating an empty songs array
// songs = [String]()

// Combining two arrays with + operator
var songs2 = ["Today was a Fairytale"]
var both = songs + songs2

// Dictionaries
var Taylor = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December"
]
Taylor["middle"]

// Empty dictionary: [String: String]()

// Conditional statements
var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
} else if person == "player" {
    action = "play"
} else {
    action = "cruise"
}

stay_out_too_late = true
var nothing_in_brain = true

if stay_out_too_late && nothing_in_brain {
    action = "cruise"
}

if !stay_out_too_late && !nothing_in_brain {
    action = "cruise"
}

// Loops

// Closed range operator: ...
for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var lyrics = "Fakers gonna"
for _ in 1...5 {
    lyrics += " fake"
}
print(lyrics)

// Half open range operator
1..<3

// Loop through array
for song in songs {
    print("My favorite song is \(song)")
}

for i in 0..<songs.count {
    print("My favorite song is \(songs[i])")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]
for i in 0..<people.count {
    var str = "\(people[i]) gonna"
    for _ in 1...5 {
        str += " \(actions[i])"
    }
    print(str)
}

// break: breaks out of the closest loop
// continue: breaks out of the current loop iteration and continues to the next iteration

var counter = 0
while true {
    print("Counter is now \(counter)")
    counter += 1
    
    if counter == 25 {
        break
    }
}

// Switch case
let live_albums = 2
switch live_albums {
case 0:
    print("You're just starting out")
case 1:
    print("You just released iTunes Live From SoHo")
case 2:
    print("You just released Speak Now World Tour")
case 3...5:
    print("You're world famous!")
default:
    print("Have you done something new?")
}