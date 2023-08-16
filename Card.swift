//
//  Card.swift
//  Concentration
//
//  Created by Владимир Ведерников on 15.08.2023.
//

import Foundation

struct Card{
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identificatorNumber = 0
    // значит, что переменная не принадлежит экземпляру класса, а принадлежит самому типу объекта
    
    static func identifierGenerator() -> Int {
        identificatorNumber += 1
        return identificatorNumber
    }
    
    init() {
        self.identifier = Card.identifierGenerator()
    }
    
}
