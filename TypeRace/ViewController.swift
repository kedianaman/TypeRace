//
//  ViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/11/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    var words = [String]() // maybe use this?
    var currentCharacterIndex = 0
    var currentWordIndex = 0
    var incorrectInput = false
    var incorrectInputIndex = 0
    
    enum InputType {
        case correct
        case incorrect
        case backspace
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerptLabel.attributedText = NSAttributedString(string: excerptLabel.text!)
        inputTextField.autocorrectionType = UITextAutocorrectionType.no
        inputTextField.delegate = self
        words = excerptLabel.text!.components(separatedBy: " ")
        shouldHighlightExcertWord(highlight: true, wordIndex: currentWordIndex, startCharacterIndex: currentCharacterIndex)
        
    }
    
    
    @IBAction func end(_ sender: Any) {
        print("Editing ended");
        resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputString = string
        
        if (inputString.count != 0) {
            // mark as incorrect despite input
            if (incorrectInput == true) {
                if (currentCharacterIndex - incorrectInputIndex > 5) {
                    return false
                }
                updateExcerptText(ofType: InputType.incorrect)
                currentCharacterIndex = currentCharacterIndex + 1
                return true
            }
            
            let character = String(excerptLabel.text![currentCharacterIndex])
             // Correct input -> Make letter blue
            if (inputString == character) {
                print("same at index: \(currentCharacterIndex)")
                updateExcerptText(ofType: InputType.correct)
                currentCharacterIndex = currentCharacterIndex + 1
                // if user enters white space, empty out textfield.
                if (inputString == " ") {
                    textField.text = ""
                    currentWordIndex = currentWordIndex + 1
                    print(words[currentWordIndex])
                    // highlight next word and dehighlight previous word
                    shouldHighlightExcertWord(highlight: true, wordIndex: currentWordIndex, startCharacterIndex: currentCharacterIndex)
                    let previousWordStartIndex = currentCharacterIndex - words[currentWordIndex - 1].count - 1
                    shouldHighlightExcertWord(highlight: false, wordIndex: currentWordIndex - 1, startCharacterIndex: previousWordStartIndex)
                    return false
                }
            // Incorrect input -> Highlight Red and mark incorrect
            } else {
                updateExcerptText(ofType: InputType.incorrect)
                incorrectInput = true
                incorrectInputIndex = currentCharacterIndex
                currentCharacterIndex = currentCharacterIndex + 1
                return true
            }
        // Backspace pressed.
        } else {
            print("delete at index: \(currentCharacterIndex)")
            currentCharacterIndex = currentCharacterIndex - 1
            if (currentCharacterIndex == incorrectInputIndex) {
                incorrectInput = false 
            }
            updateExcerptText(ofType: InputType.backspace)
            return true
        }
        return true
    }
    
    func updateExcerptText(ofType: InputType) {
        
        let attributedText = NSMutableAttributedString(attributedString: excerptLabel.attributedText!)
        let colorRange = NSRange(location: currentCharacterIndex, length: 1)
        switch ofType {
        case .correct:
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: colorRange)
        case .incorrect:
            attributedText.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.red, range: colorRange)
        case .backspace:
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: colorRange)
            attributedText.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.clear, range: colorRange)
        }
        excerptLabel.attributedText = attributedText
    }
    
    func shouldHighlightExcertWord(highlight: Bool, wordIndex: Int, startCharacterIndex: Int) {
        
        let attributedExcerptText = NSMutableAttributedString(attributedString: excerptLabel.attributedText!)
        let currentWordLength = words[wordIndex].count
        let currentRange = NSRange(location: startCharacterIndex, length: currentWordLength)
        attributedExcerptText.addAttribute(NSAttributedStringKey.underlineStyle, value: highlight ? 1 : 0, range: currentRange)
        let boldFont = UIFont.boldSystemFont(ofSize: 22)
        let normalFont = UIFont.systemFont(ofSize: 20)
        attributedExcerptText.addAttribute(NSAttributedStringKey.font, value: highlight ? boldFont : normalFont, range: currentRange)
        excerptLabel.attributedText = attributedExcerptText
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
  

    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

