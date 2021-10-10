/**
 * Day 12
 * Optionals
 **/

// Optional variables
// Use ? with typehint to show that it can be 'nil'
var age: Int? = nil
age = 17

// 'nil' means no value, 'null' in other languages

// Unwrapping optionals with a conditional
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name")
}

// Unwrapping with guard let
// guard let requires that you leave the current function, loop, or condition if nil is found
// Use when you want to make sure conditions are correct before continuing
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!")
}
greet(nil)

// Crash operator '!' aka force unwrap operator
// Will turn an optional value into a regular value
// Program will crash if value was nil
let str = "5"
let int = Int(str)!

// Implicitly unwrapped optionals
// Don't need to unwrap them to use them as regular variables
// BUT: If they are nil and used, the code will crash
let score: Int! = nil

// nil coalescing
func username(for id: Int) -> String? {
    if (id == 1) {
        return "Taylor Swift"
    } else {
        return nil
    }
}
// Note: the default value must be the same type as the variable being unwrapped
let user = username(for: 15) ?? "Anonymous"

// Optional chaining
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()

let painters = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = painters["Vincent"]?.first?.uppercased()

// Optional Try
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("Well that didn't work")
}

try! checkPassword("s3krit")
print("OK")

// Failable initializers
let numeric_str = "5"
let converted = Int(5)

// Failable initializers can be made by adding '?' to 'init'
struct Person {
    var id: String
    
    init?(id: String) {
        guard id.count == 9 else {
            return nil
        }
        
        self.id = id
    }
}

// Typecasting
class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("Bark!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

