//
//  Card.swift
//  FlipCardGame
//
//  Created by 小王子 on 2022/3/16.
//

import Foundation

struct Card : Hashable{
    
    var hashValue: Int{
        return identifier
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    //ues struct when var are pure-value-type
    //copy by value
    var isFaceUp = false
    var isMatched = false
    private var identifier:Int // useID, not emoji
    
    static var identifierFactory = 0
    static func getUniqueldentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    
    init(){
        self.identifier = Card.getUniqueldentifier()
    }
}
