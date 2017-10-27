import Foundation

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.isEqual(rhs);
}

class Card : NSObject {
    var color: Color
    var value: Value
    override var description: String {
        return "\(value) of \(color)"
    }
    
    init (color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Card {
            if self.color == object.color && self.value == object.value {
                return true
            }
            return (false);
        }
        return false
    }
}
