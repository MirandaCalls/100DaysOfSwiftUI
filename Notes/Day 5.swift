/**
 * Day 5
 * Functions
 */

// Basic function
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    
    print(message)
}

printHelp()

// Function parameters & returning values
func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 4)
print("Square of 4 is: \(result)")

// Two names can be used for function parameters
// One for calling the function and one for use in the function
func sayHello(to name: String) {
    print("Hello, \(name)")
}

sayHello(to: "Taylor")

// Redacting parameter names
func sayHello2(_ name: String) {
    print("Hello, \(name)")
}

sayHello2("Taylor")

// Default parameter values
func greet(_ name: String, nicely: Bool = true) {
    if nicely {
        print("Hello, \(name)!")
    } else {
        print("Oh no, it's \(name) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

// Variadic functions
// Any number of arguments to give a function
print("Haters", "gonna", "hate")

func variadicSquare(numbers: Int...) {
    for number in numbers {
        let square = number * number
        print("\(number) squared is \(square)")
    }
}

variadicSquare(numbers: 1, 2, 3, 4, 5)

// Writing throwing functions
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}
// Note: Quiz had a jab at pineapple pizza

// Running throwing functions
do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("That password is bad")
}

// inout parameters
// All function parameters are always constant
// You can specify a parameter to be "inout" which will let you change the value in place to be reflected outside the function
func doubleInPlace(number: inout Int) {
    number *= 2
}

// like PHP's by reference parameters
var my_num = 10
doubleInPlace(number: &my_num)
print(my_num)
