//
//  Button.swift
//  SimpleCaculator
//
//  Created by 小王子 on 2022/4/25.
//

import Foundation

struct Button{
    //ues struct when var are pure-value-type
    //copy by value
    var type : String?
    var isClicked = false
    var identifier:Int // useID, not emoji
    var text:String?
    
    static var identifierFactory = 0
    static func getUniqueldentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Button.getUniqueldentifier()
    }
}

