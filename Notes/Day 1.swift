/**
 * Day 1
 * Variables, constants, string interpolation, multi-line strings
 */

// strings
var str = "Hello, playground"
str = "Goodbye"

// Automatically includes \n sequences
var str1 = """
This goes
over multiple
lines
"""

// The \ tells swift to not include \n sequences
var str2 = """
This goes \
over multiple \
lines
"""

// string interpolation
var score = 85
var str3 = "Your score was \(score)"
var results = "Your test results are here: \(str3)"

// integers
var age = 38
var population = 8_000_000

// doubles
var pi = 3.141

// boolean
var awesome = true

// constants
let taylor = "swift"

// type annotations
let var_str = "Hello, playground"
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylor_rocks: Bool = true
