/**
 * Day 9
 * Structs Part 2
 */

// Struct Initializers
struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Created a new user!")
    }
}

var anonymous = User()
print(anonymous.username)

// "self" Referencing current struct instance
struct Person {
    var name: String
    
    init(name: String) {
        self.name = name
        print("\(self.name) was born!")
    }
}

var Nathan = Person(name: "Nathan Fillion")

// Lazy properties
struct WarpDrive {
    var maxSpeed = 10
    
    init() {
        print("Warp coils warming up!")
    }
}

struct Starship {
    var designation: Int
    var name: String
    lazy var warpDrive = WarpDrive()
}

var Voyager = Starship(designation: 74656, name: "Voyager")
print(Voyager.designation)
print("Max warp speed of \(Voyager.warpDrive.maxSpeed)")

// Static properties and methods
struct Student {
    static var classSize = 0;
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

var Ed = Student(name: "Ed")
var Taylor = Student(name: "Taylor")
print("Class size: \(Student.classSize)")

// Access control
struct EvilVillain {
    private var realName: String
    var name: String
    
    init(realName: String, name: String) {
        self.realName = realName
        self.name = name
    }
    
    func identify() {
        print("My real name is \(self.realName)")
    }
}

let DrHorrible = EvilVillain(realName: "Billy Buddy", name: "Dr. Horrible")
DrHorrible.identify()

