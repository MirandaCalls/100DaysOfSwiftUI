/**
 * Day 4
 * Loops
 **/

// For loops
let count = 1...10
for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

// _ used to skip using a variable in a for
print("Players gonna ")
for _ in 1...5 {
    print("play")
}

// While loops
var number = 1
while number <= 20 {
    print(number)
    number += 1
}
print("Ready or not, here I come!")

// Repeat loops (aka do/while)
number = 1
repeat {
    print(number)
    number += 1
} while number <= 20
print("Ready or not, here I come!")

// Exiting loops
var count_down = 10
while count_down >= 0 {
    print(count_down)
    
    if count_down == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    count_down -= 1
}
print("Blast off!")

// Exiting multiple loops (break)
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// Skipping items (continue)
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    
    print(i)
}

// Infinite loops
// while true { ... }
