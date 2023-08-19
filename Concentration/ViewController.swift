//
//  ViewController.swift
//  Concentration
//
//  Created by Владимир Ведерников on 14.08.2023.
//

import UIKit
//import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .
    }
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
    // lazy - реально не будет инициализировано до тех пор, пока кто-то не попытается ее использовать
    
    var touches = 0 {
        didSet{
            touchLabel.text = "Тыкнул: \(touches)"
        }
    }
    
    var emojiCollection = ["🤖","🐶","🍏","🏂","🍄","🦊","🐝","🍕","🚎","🧯","🥑","⛸️"]
    
    var emojiDictionary = [Int:String]()
    
    func emojiIdentifier(for card: Card) -> String {
        
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?" // проверка, если не nil то наше, иначе дефолтное значение
    }
    
    func updateViewFromModel() {
        let generator = UISelectionFeedbackGenerator()
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = UIColor.lightGray
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.systemGreen : UIColor.systemBlue
                //if card.isMatched {
                //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                //AudioServicesPlayAlertSoundWithCompletion(SystemSoundID, (kSystemSoundID_Vibrate)) {}
                //}
                generator.selectionChanged()
            }
        }
    }
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
        
    }

}

