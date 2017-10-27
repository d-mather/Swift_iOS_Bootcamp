import UIKit

//----------------//
//   var, let     //
//----------------//

var str1 = "Hello";
var str2: String = "World";
str2 = str1;

let pi = 3.14;
//pi = 2;
//let pi: Float = 3.14;

//----------------//
//     tuple      //
//----------------//

let tuple = (str1, pi);
print(tuple);

let anotherTuple: (String, String, Int) = ("This", "is", 24);
print(anotherTuple);
print(anotherTuple.2);

//-------------------//
// array, Dictionary //
//-------------------//

var fruits: [String] = [String]()
fruits.append("Strawberry");
fruits.append("banana");
fruits.append("peach");
print(fruits.first)
print(fruits[2]);

var persons = [String : Int]()
persons["toto"] = 12;
persons["Martin"] = 64;
print(persons["toto"])
print(persons["Maxime"])

//----------------//
//    Optional    //
//----------------//

var opInt: Int? = 3;
print(opInt);
print(opInt!);

opInt = 0;
print(opInt);
print(opInt!);

var opString: String! = "foo";
print(opString);
print(opString!);

opString = "bar";
print(opString);
print(opString!);


//----------------//
//      Weak      //
//----------------//

var button: UIButton? = UIButton()
CFGetRetainCount(button);

weak var buttonRef = button;
CFGetRetainCount(button);

buttonRef = nil;
CFGetRetainCount(button);

//----------------//
//    for, while  //
//----------------//

var i = 1;
while i <= 100 {
    print(i);
    i += 1;
}

for fruit in fruits {
    print(fruit);
}

//----------------//
//    if, let     //
//----------------//

var optInt: Int? = 4;
//optInt = nil;
if let number = optInt {
    print(number);
}

//----------------//
//    structs     //
//----------------//

struct PointStruct {
    var x: Double
    var y: Double
    
    mutating func makeOrigin() {
        x = 0;
        y = 0;
    }
}

//----------------//
//    classes     //
//----------------//

class PointClass {
    var x: Double
    var y: Double
    
    init (x: Double, y: Double) {
        self.x = x;
        self.y = y;
    }
    
    func makeOrigin() {
        x = 0;
        y = 0;
    }
    
    func toString() -> String {
        return "\(x) \(y)";
    }
}

//----------------//
//    extension   //
//----------------//

extension PointStruct {
    func toString() -> String {
        return "\(x) \(y)";
    }
}

//-----------------//
// class vs struct //
//-----------------//

var p1 = PointStruct(x: 21, y: 24)
//var p1 = PointClass(x: 21, y: 24)
var p2 = p1;
print(p1.toString())
print(p2.toString())
p1.x = 0;
print(p1.toString())
print(p2.toString())

//---------------------------------//
// inheritance, override, overload //
//---------------------------------//

class Point : PointClass {
    override func toString() -> String {
        return "(x: \(x), y: \(y))";
    }
    
    func toString(char: Character) -> String {
        return "\(char)";
    }
}

let p = Point(x: 84, y: 168)
print(p.toString())
print(p.toString(char: "G"))

//-----------------//
//      Enum       //
//-----------------//

enum TrafficLight {
    case Green
    case Orange
    case Red
}

let light = TrafficLight.Orange
light.hashValue

//-----------------//
//   nested types  //
//-----------------//

enum DoorState : String {
    case Open = "The door is open"
    case Closed = "The door is closed"
}

let door = DoorState.Open
door.rawValue

//-----------------//
//     generics    //
//-----------------//

//enum Option {
//    case Nil
//    case Value(Int)
//}

enum Option<T> {
    case Nil
    case Value(T)
}

var intOpt = Option.Value(24)

//intOpt = .Nil

switch intOpt {
    case .Nil:
        print ("Number is nil")
    case .Value (let n):
        print("Number is equal to \(n)")
}

//-----------------//
//    Properties   //
//-----------------//

struct Person {

//--------stored properties
    var name: String

//--------Observers
    var age: Int {
        willSet {
            print("\(name) will change his age from \(age) to \(newValue)");
        }
        didSet {
            print("\(name) did change his age from \(oldValue) to \(age)");
        }
    }

//--------Computed Properties
    var description: String {
        get {
            return "name: \(name), age: \(age)"
        }
    }
    var isMinor: Bool {
        get {
            return age < 18
        }
        set {
            if newValue {
                age = 17
            }
            else {
                age = 18
            }
        }
    }
}

var joe = Person(name: "Joe", age: 12)
joe.description
joe.isMinor
joe.age = 24
joe.isMinor = true
joe.description

//-----------------//
//  Function Type  //
//-----------------//

var operations : [String : (Int, Int) -> Int] = [:]

func add(n1: Int, n2: Int) -> Int {
    return n1 + n2
}

operations["+"] = add
operations["+"]?(3,4)
operations["+"]!(3,4)

//-----------------//
//     Closures    //
//-----------------//

operations["-"] = {
    (n1: Int, n2: Int) -> Int in // this line is optional
    return n1 - n2
}

operations["*"] = {
    return $0 * $1 // default parameter names
}

operations["/"] = {
    $0 / $1
}

operations["+"] = (+)

//-----------------//
//       Cast      //
//-----------------//

//       is
//       as, as?, as!

class Animal {
    var numberOfLegs = 0
}

class Dog : Animal {
    override init() {
        super.init()
        numberOfLegs = 4
    }
    
    func bark() {
        print("Woof !")
    }
}

class Bird : Animal {
    override init() {
        super.init()
        numberOfLegs = 2
    }
    
    func fly() {
        print("Bird fly away.")
    }
}

var animals = [Animal]()

animals.append(Dog())
animals.append(Bird())
animals.append(Bird())
animals.append(Dog())
animals.append(Bird())

for animal in animals {
    if animal is Dog {
        print("It's a dog !")
        let dog = animal as! Dog
        dog.bark()
    }
    else if animal is Bird {
        print ("It's a bird !")
    }
    else {
        print("I don't know what it is.")
    }
    let bird = animal as? Bird
    bird?.fly()
}





































