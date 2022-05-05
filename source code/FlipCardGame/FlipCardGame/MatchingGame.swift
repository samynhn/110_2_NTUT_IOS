//
//  MatchingGame.swift
//  FlipCardGame
//
//  Created by 小王子 on 2022/3/16.
//

import Foundation

struct MatchingGame{ // change class to struct
    //copy by reference
    var cards: Array<Card> = [Card]()
    var indexOfOneAnsOnlyFaceUpCard: Int?
    var isFaceUpIndexArray = Array<Int>()
    var gameScore:Int = 0
    var fCount :Int = 0
    var emojiChoices: Array<String> = Array()
    var animal = ["🐵","🐭", "🦊", "🐼", "🦁", "🐔", "🐸", "🦄"]
    var car = ["🚗","🚕", "🚙", "🚓", "🚑", "🛻", "🚜", "🛵"]
    var sport = ["⚽️","🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏓"]
    var food = ["🥐","🧀", "🍞", "🌭", "🍔", "🍟", "🍕", "🌮"]
    var themeName = "none"
    var flag = 0
    var isFaceDownCardNum = 0
    var randomTheme: Array<String> = Array()
    var theme: Dictionary<Int, Array<String>>{
        get{
            return [0:animal, 1:car, 2:sport, 3:food]
        }
    }
    var themeNameArray = ["animal", "car", "sport", "food"]
    
    var randomThemeIndex = 0
    
 //###### func ######
    func getRandomThemeIndex(themeArray: Dictionary<Int, Array<String>>)->Int{
        return Int(arc4random_uniform(UInt32(themeArray.count)))
    }
    // add mutating
    mutating func getRandomTheme(index: Int)->(String,Array<String>){
        themeName = themeNameArray[index]
        if theme[index] != nil{
            randomTheme = theme[index]!
        }
        return (themeName,randomTheme)
    }
    
    mutating func chooseCard(at index: Int){
//        if cards[index].isFaceUp{
//            cards[index].isFaceUp = false
//        }else{
//            cards[index].isFaceUp = true
//        }
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAnsOnlyFaceUpCard, matchIndex != index{ // indexOfOneAnsOnlyFaceUpCardu has value and matchIndex != index then true
                
                if cards[matchIndex] == cards[index]{// if emoji are same
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cards[matchIndex].isFaceUp = true
                    cards[index].isFaceUp = true
                    indexOfOneAnsOnlyFaceUpCard = nil
                    gameScore += 30
                }else{
                // when emoji are different
                cards[index].isFaceUp = true
                indexOfOneAnsOnlyFaceUpCard = nil
                gameScore -= 10
                }
            }else if indexOfOneAnsOnlyFaceUpCard == index{
                cards[index].isFaceUp = false
                indexOfOneAnsOnlyFaceUpCard = nil
                gameScore -= 10
            }else{//no card face up
                for flipDownIndex in cards.indices{
                    if cards[flipDownIndex].isMatched{
                        cards[flipDownIndex].isFaceUp = true
                    }else{
                    cards[flipDownIndex].isFaceUp = false
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAnsOnlyFaceUpCard = index
            }
        }
    }

    mutating func reset(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            indexOfOneAnsOnlyFaceUpCard = nil
            gameScore = 0
            fCount = 0

            

            
        }
    }
    
    mutating func flipAll(){
        var _isFaceUpIndexArray = Array<Int>()
//        gameScore -= 1000
        fCount = 0
        for index in cards.indices{ // to get num of faceDown card
            if cards[index].isFaceUp == false{
                _isFaceUpIndexArray.append(index)
                isFaceDownCardNum+=1
            }
        }
        if _isFaceUpIndexArray.count != 0{ // when all cards faceUp wont do
            isFaceUpIndexArray = _isFaceUpIndexArray
            gameScore -= 1000

        }
        
        
        
        if isFaceDownCardNum==0{ // all cards faceUp
            for index in isFaceUpIndexArray{
                cards[index].isFaceUp = false
            }
            isFaceUpIndexArray.removeAll()
        }else{
            for index in isFaceUpIndexArray{
                cards[index].isFaceUp = true
                isFaceDownCardNum-=1
            }
            
        }
    }
    
    func isAllMatched()-> Bool{
        
        var MatchedNum = 0
        
        for card in cards{
            if card.isMatched{
                MatchedNum += 1
            }
        }
        return MatchedNum == cards.count
           
    }
       
//    var emojiDict = Dictionary<Int, String>()
    var emojiDict = [Card:String]()
    
    mutating func emoji(for card: Card)-> String{
        if emojiDict[card] == nil,randomTheme.count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(randomTheme.count)))
            emojiDict[card] = randomTheme.remove(at: randomIndex)
        }
        
        
        return emojiDict[card] ?? "?"
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
