//
//  MatchingGame.swift
//  FlipCardGame
//
//  Created by 小王子 on 2022/3/16.
//

import UIKit

//extension Int{
//    var arc4random: Int{
//        return Int(arc4random(UInt32((self)))
//    }
//}
                   
class ViewController: UIViewController {
    
    lazy var game:MatchingGame = MatchingGame(numberOfPairsOfCards:(cardButtons.count+1)/2)//call initalizers
    
    @IBOutlet weak var flipLabel: UILabel!
    
    @IBOutlet weak var gameScore: UILabel!
    
    @IBOutlet weak var theme: UILabel!

    
    var fCount:Int = 0 {
        didSet{
            flipLabel.text = "Fliped: \(fCount)"
        }
    }

    @IBOutlet var cardButtons: [UIButton]!

    
    
//    var emojiDict = Dictionary<Int, String>()
//
//    func emoji(for card: Card)-> String{
//        if emojiDict[card.identifier] == nil,game.randomTheme.count>0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(game.randomTheme.count)))
//            emojiDict[card.identifier] = game.randomTheme.remove(at: randomIndex)
//        }
//
//
//        return emojiDict[card.identifier] ?? "?"
//    }
    
    @IBAction func flipCount(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
        
            updateViewFromModel()
        }else{
            print("not in the collection")
        }
        fCount += 1
        
    }
    
    func getEmoji(for card: Card)->String{
        return "?"
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(game.emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 0.2046771523) : #colorLiteral(red: 0, green: 0.594068706, blue: 0.9980753064, alpha: 1)
                
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
            }
            gameScore.text = "Game score: \(game.gameScore)"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let (name, _) = game.getRandomTheme(index: game.getRandomThemeIndex(themeArray: game.theme))
        theme.text = "Theme: \(name)"
        // Do any additional setup after loading the view.
    }
    @IBAction func reset(_ sender: Any) {
        game.reset()
        fCount = 0
//        game.emojiDict.removeAll()
        
        let (name, _) = game.getRandomTheme(index: game.getRandomThemeIndex(themeArray: game.theme))
        theme.text = "Theme: \(name)"
        game.emojiDict.removeAll()
        game.cards.shuffle()
        updateViewFromModel()
        
    }
    @IBAction func flipAll(_ sender: Any) {
        game.flipAll()
        if game.isAllMatched(){
            reset(self)
        }
        fCount = 0
        updateViewFromModel()
    }
    
  
    /*
    @IBAction func FlipFirstCard(_ sender: UIButton) {
        if sender.currentTitle == "🐒" {
            sender.setTitle("", for: UIControl.State.normal)
            sender.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }else {
            sender.setTitle("🐒", for: UIControl.State.normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.9798733592, blue: 0.9324343801, alpha: 1)
        }
        fCount += 1
    }
    */
    
}

