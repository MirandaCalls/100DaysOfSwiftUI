/**
 * Day 6
 * Closures Part 1
 */

// Basic closure example
// Function that can be assigned to a variable then used as the name of the variable
let driving = {
    print("I'm driving in my car.")
}

driving();

// Closure with parameters
let drivingTo = { (place: String) in
    print("I'm driving to \(place) in my car.")
}

// You CANNOT use labels when calling a closure with parameters
drivingTo("Japan")

// Use arrow -> syntax to specify return value
let drivingWithReturn = { (place: String) -> String in
    return "I'm driving to \(place) in my car."
}

let message = drivingWithReturn("Tokyo")
print(message)

// Passing a closure as a parameter to a function
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I've arrived.")
}

travel(action: driving)

// Trailing closure syntax
// If a closure is the last parameter of a function, you can use this special syntax to run closure code
travel {
    print("I'm flying in my plane.")
}
