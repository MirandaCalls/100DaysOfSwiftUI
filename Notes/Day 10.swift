/**
 * Day 10
 * Classes
 **/

// Basic class
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Bark!")
    }
}

var Shiloh = Dog(name: "Shiloh", breed: "Beagle")

// Property inheritance
// Method override
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    
    override func makeNoise() {
        print("Yip!")
    }
}

var Reggie = Poodle(name: "Reggie")
Reggie.makeNoise()

// final keyword prevents you from subclassing or overriding methods
final class StarDrive {
    var speed: Int
    
    init(speed: Int) {
        self.speed = speed
    }
}

// Copying objects
// Classes in swift are by reference
class Singer {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let singer = Singer(name: "Taylor Swift")
print(singer.name)

let singer_copy = singer
singer_copy.name = "Justin Beiber"

// Singer's name is now Justin Beiber since singer_copy still points to singer
print(singer.name)

// Deinitializer
class Person {
    var name = "John Doe"
    
    init() {
        print("\(self.name) is now alive.")
    }
    
    func greet() {
        print("Hello, I'm \(self.name).")
    }
    
    deinit {
        print("I'm meeeeelting ahhhhhh!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.greet()
}

// Mutability
// Classes are different from structs since a constant instance can still change it's properties
// Only structs needs to use the 'mutating' keyword for functions that change properties too
let taylor = Singer(name:"Taylor Swift")
taylor.name = "Ed"
print("I've changed my name to \(taylor.name)")
