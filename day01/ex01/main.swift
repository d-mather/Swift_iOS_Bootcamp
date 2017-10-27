import Foundation
print("===============TEST CARD CLASS===============")
let card = Card(color: Color.SPADE, value: Value.QUEEN)
print("Create card 1 : \(card.description)")
let othercard = Card(color: Color.SPADE, value: Value.KING)
print("Create card 2 : \(othercard.description)")
let samecard = Card(color: Color.SPADE, value: Value.QUEEN)
print("Create card 3 : \(samecard.description)")
print("\n")
print("test override isEqual method")
print("Cards 1 & 2 is equal : \(card.isEqual(othercard))")
print("Cards 1 & 3 is equal : \(card.isEqual(samecard))")
print("\n")
print("test overload == operator")
if (card == othercard) {
    print("Card 1 & 2 is equal")
}
else {
    print("Card 1 & 2 is not equal")
}
if (card == samecard) {
    print("Card 1 & 3 is equal")
}
else {
    print("Card 1 & 3 is not equal")
}
