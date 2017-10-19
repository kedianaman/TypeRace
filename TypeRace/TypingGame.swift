//
//  TypingGame.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/19/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import Foundation
import UIKit

class TypingGame {
    var quote: Quote!
    var currentCharacterIndex = 0
    var currentWordIndex = 0
    var totalCharactersInput = 0;
    var incorrectInput = false
    var incorrectInputIndex = 0
    var wordsPerMinute = 0
    var seconds = 0
    var timer = Timer()
    
    
    enum InputType {
        case correct
        case incorrect
        case backspace
    }
    
    init() {
        let quotes = Quotes()
        self.quote = quotes.getRandomQuote()
    }
    
    func updateGameFor(input: String) {
        
    }
    
}
