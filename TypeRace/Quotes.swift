//
//  Quotes.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/15/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import Foundation

class Quotes {
    var quotes = [QuoteLocal]()
    init() {
        let wordListPath = Bundle.main.path(forResource: "samplequotes", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: wordListPath!))
            let quotesData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: String]]
            for quote in quotesData {
                let newQuote = QuoteLocal(quoteText: quote["quoteText"]!, quoteAuthor: quote["quoteAuthor"]!)
                self.quotes.append(newQuote)
            }
            for quote in self.quotes {
                print("quote text: \(quote.quoteText!) - \(quote.quoteAuthor!)")
            }
        } catch {
            
        }
    }
    func getRandomQuote() -> QuoteLocal? {
        if quotes.count != 0 {
            let randomNumber = Int(arc4random_uniform(UInt32(quotes.count)))
            return quotes[randomNumber]
        } else {
           return nil
        }
    }
    
}

class QuoteLocal: Decodable {
    var quoteText: String!
    var quoteAuthor: String!
    
    init(quoteText: String, quoteAuthor: String) {
        self.quoteText = quoteText
        self.quoteAuthor = quoteAuthor
    }
}

class Quote: Decodable {
    var quote: String!
    var author: String!
    
    init() {
        let url = URL(string: "https://talaikis.com/api/quotes/random/")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print("Error")
            } else {
                if let content = data {
                    do {
                        let quote = try JSONDecoder().decode(Quote.self, from: content)
//                        print(quote.quote)
//                        print(quote.author)
                    }
                    catch {
                        
                    }
                }
            }
        }
        task.resume()
    }
}
