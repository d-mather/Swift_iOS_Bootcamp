print("===============TEST COLOR ENUM===============")
let cardColor = Color.HEART
print("create cardColor = \(cardColor) ; raw value = \(cardColor.rawValue)")

switch cardColor {
case Color.HEART:
    print("cardColor is \(Color.HEART.rawValue)")
case Color.DIAMOND:
    print("cardColor is \(Color.DIAMOND.rawValue)")
case Color.SPADE:
    print("cardColor is \(Color.SPADE.rawValue)")
case Color.CLUB:
    print("cardColor is \(Color.CLUB.rawValue)")
}
print("\n")
let arrColors = Color.allColors
print("create Array of allColors")
print("print arrColors")
for color in arrColors {
    print("\(color)   :   \(color.rawValue)");
}
print("\n\n")
print("===============TEST VALUE ENUM===============")
let cardValue = Value.ONE
let otherCardValue = Value.FIVE
print("create cardValue = \(cardValue) ; raw value = \(cardValue.rawValue)")
switch cardValue {
case Value.ONE:
    print("cardValue is \(Value.ONE.rawValue)")
case Value.TWO:
    print("cardValue is \(Value.TWO.rawValue)")
case Value.THREE:
    print("cardValue is \(Value.THREE.rawValue)")
case Value.FOUR:
    print("cardValue is \(Value.FOUR.rawValue)")
default:
    print("cardValue is sup to \(Value.FOUR)")
}
print("\n")
print("create otherCardValue = \(otherCardValue) ; raw value = \(otherCardValue.rawValue)")
switch otherCardValue {
case Value.ONE:
    print("otherCardValue is \(Value.ONE.rawValue)")
case Value.TWO:
    print("otherCardValue is \(Value.TWO.rawValue)")
case Value.THREE:
    print("otherCardValue is \(Value.THREE.rawValue)")
case Value.FOUR:
    print("otherCardValue is \(Value.FOUR.rawValue)")
default:
    print("otherCardValue is up to \(Value.FOUR)")
}
print("\n")
let arrValues = Value.allValues
print("create Array of allValues")
print("print arrValues")
for value in arrValues {
    print("\(value)   :   \(value.rawValue)");
}
