/**
 * Day 11
 * Protocols, extensions, protocol-oriented programming
 **/

// Basic protocol
protocol Identifiable {
    // get set determines whether property is a var or a let
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My id is \(thing.id).")
}

// Protocol inheritance
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

// Extensions
// Adding additional methods to an existing type
extension Int {
    // You can only add computed properties and functions
    var isEven: Bool {
        return self % 2 == 0
    }
    
    func squaured() -> Int {
        return self * self
    }
}

var integer = 4;
integer = 4.squaured()
var is_even = integer.isEven

// Protocol Extensions
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

// POP
//  protocol Identifiable {
//      var id: String { get set }
//      
//      func identify()
//  }

extension Identifiable {
    // Providing default implementation for identify
    
    func identify() {
        print("My id is \(id)")
    }
}

var Geoffrie = User(id: "mirandacalls")
Geoffrie.identify()

// Don't start with a class, start with a protocol
protocol Ordered {
    func precedes(other: Self) -> Bool
}

// When to use classes?
// You want implicit sharing when
// - Copying or comparing instances doesn't make sense
// - Instance lifetime is tied to external effects
// - Instances are just "sinks" write-only conduits to external state (e.g. CGContext)

// Don't fight the system
// - If a framework expects you to subclass, or to pass an object, do it

// On the other hand
// - Nothing in software should grow too large
// - When factoring something out of a class, consider a non-class
