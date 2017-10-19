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
    var accuracy = 0
    var wordsPerMinute = 0
    var seconds = 0
    
    

    init() {
        let quotes = Quotes()
        self.quote = quotes.getRandomQuote()
    }
    
}
