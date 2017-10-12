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
    var currentIndex = 0;
    
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
    }
    
    
    @IBAction func end(_ sender: Any) {
        print("Editing ended");
        resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count != 0) {
            let character = String(excerptLabel.text![currentIndex])
            if (string == character) {
                print("same at index: \(currentIndex)")
                updateExcerptText(ofType: InputType.correct)
                currentIndex = currentIndex + 1
                if (string == " ") {
                    textField.text = ""
                    return false
                }
            } else {
                print("different at index: \(currentIndex)")
                updateExcerptText(ofType: InputType.incorrect)
                currentIndex = currentIndex + 1
                return true
            }
        } else {
            
            print("delete at index: \(currentIndex)")
            currentIndex = currentIndex - 1
            updateExcerptText(ofType: InputType.backspace)
            return true
        }
        return true
    }
    
    func updateExcerptText(ofType: InputType) {
        
        let attributedText = NSMutableAttributedString(attributedString: excerptLabel.attributedText!)
        let colorRange = NSRange(location: currentIndex, length: 1)
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

