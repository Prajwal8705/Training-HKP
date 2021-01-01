var Reads = true
var able = "Hello this is my first and it's \(Reads) that I read"
print(able)
var names: [String] = ["Bob", "Harry", "buliding"]
print(names[1])
var name = "Bob"

enum Buildings { 
    case tower(height: Int)
    case skyscraper(height: Double)
}
var Burj = Buildings.skyscraper(height: 112.0)
print(Burj)