/**
 * Day 3
 * Swift Operators
 **/

// Arithmetic operators
let first_score = 12
let second_score = 4

let total = first_score + second_score
let difference = first_score - second_score
let product = first_score * second_score
let divided = first_score / second_score
let remainder = 13 % second_score

// Becomes 90000000000000000
let value: Double = 90000000000000001

// Operator Overloading
let dandelion = "Toss a coin "
let song = dandelion + "for your witcher"

let first_half = ["John", "Paul"]
let second_half = ["George", "Ringo"]
let beatles = first_half + second_half

// Note: Also, Swift allows you to modify its  operators 🤯

// Compound assignment operators "shorthand"
var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

let score_1 = 6
let score_2 = 4
score_1 == score_2
score_1 != score_2
score_1 < score_2
score_1 > score_2
"Taylor" <= "Swift"

// Note: Comparable enums is cool
// I keep wanting to end lines with ;

// Conditions
var first_card = 10
var second_card = 11
if first_card + second_card == 2 {
    print("Aces A lucky!")
} else if
    first_card + second_card == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

// Note: Takes me back to my Java days with all the type safety that came with that language

// Combining conditions
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}

// Ternary operators
first_card = 11
second_card = 10
print(first_card == second_card ? "Cards are the same" : "Cards are different")

// Note: I'm pleased at how many language always share the same behavior for certain operators like ternaries

// Switch statements
let weather = "sunny"
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

// Note: I LOVE the fact that Swift doesn't make you use breaks in switch cases. Sometimes I actually avoided using switches in other languages because of the extra typing to write it out compared to a normal if/else

// Range operators
score = 85
switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}

let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[1..<3])

// Note: Range operators are simply black magic

