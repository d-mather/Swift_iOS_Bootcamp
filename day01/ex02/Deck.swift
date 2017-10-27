import Foundation

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map {
        return Card(color: Color.SPADE, value: $0)
    }
    static let allDiamonds: [Card] = Value.allValues.map {
        return Card(color: Color.DIAMOND, value: $0)
    }
    
    static let allHearts  : [Card] = Value.allValues.map {
        return Card(color: Color.HEART, value: $0)
    }
    
    static let allClubs   : [Card] = Value.allValues.map {
        return Card(color: Color.CLUB, value: $0)
    }
    
    static let allCards   : [Card] = {
        var arr = [Card]()
        arr += allSpades
        arr += allDiamonds
        arr += allHearts
        arr += allClubs
        return arr
    }()
}
