/**
 * Day 7
 * Closures Part 2
 */

// Closures as params w/ params
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

// Closures returning parameters
func travel2(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel2 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

// Note: Using the + operator as a closure
// let sum = reduce(numbers, using: +)

// Shorthand closure parameters
travel2 {
    "I'm going to \($0) in my car."
} // Note: I really don't like this shorthand syntax

// Shorthand closure syntax with multiple params
func travel3(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel3 {
    "I'm going to \($0) in my car at \($1) miles per hour"
}

// Function returning a closure
func travel4() -> (String) -> Void {
    {
        print("I'm going to \($0)")
    }
}

// Calling the function returned from the closure
let result = travel4();
result("London")

let result2 = travel4()("London")

// Capturing a variable inside a closure
func travel5() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let result3 = travel5()
result3("London")
result3("Russia")
result3("Tokyo")
