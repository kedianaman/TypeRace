//
//  ViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/11/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit
import AudioToolbox

class TypingGameplayViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var wpmLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var excerptLabelContainerView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputTextContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBarBorder: UIView!
    @IBOutlet weak var progressBarIndicator: UIView!
    @IBOutlet weak var progressBarIndicatorWidth: NSLayoutConstraint!
    
    var words = [String]() // maybe use this?
    var currentCharacterIndex = 0 {
        didSet {
            updateProgressBar()
        }
    }
    var currentWordIndex = 0
    var incorrectInput = false {
        didSet {
            updateTextField(incorrect: incorrectInput)
        }
    }
    var incorrectInputIndex = 0
    var wordsPerMinute = 0 {
        didSet {
            wpmLabel.text = "WPM: \(wordsPerMinute)"
        }
    }
    var seconds = 0 {
        didSet {
            timeLabel.text = "Time: \(seconds)"
        }
    }
    var timer = Timer()

    
    enum InputType {
        case correct
        case incorrect
        case backspace
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        words = excerptLabel.text!.components(separatedBy: " ")
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TypingGameplayViewController.updateCounter), userInfo: nil, repeats: true)        
    }
    
    func initialSetup() {
        excerptLabel.attributedText = NSAttributedString(string: excerptLabel.text!)
        inputTextField.autocorrectionType = UITextAutocorrectionType.no
        shouldHighlightExcertWord(highlight: true, wordIndex: currentWordIndex, startCharacterIndex: currentCharacterIndex)
        view.backgroundColor = UIColor.clear
        let backgroundLayer = CGGradient.race_bgGradient()
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        progressBarBorder.layer.cornerRadius = 15
        progressBarIndicator.layer.cornerRadius = 15
        progressBarIndicator.backgroundColor = UIColor.race_blueColor()
        addShadow(view: excerptLabelContainerView)
        addShadow(view: inputTextContainerView)
    }
    
    func updateProgressBar() {
        
        let progressBarWidth = CGFloat(Double(self.currentCharacterIndex)/Double(self.excerptLabel!.text!.count)) * self.progressBarBorder.frame.width
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.progressBarIndicatorWidth.constant = progressBarWidth
            self.progressBarIndicator.frame = CGRect(origin: self.progressBarIndicator.frame.origin, size: CGSize(width: progressBarWidth, height: self.progressBarIndicator.frame.height))
        }, completion: nil)
    }
    
    func updateTextField(incorrect: Bool) {
        UIView.transition(with: inputTextContainerView, duration: 0.3, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.inputTextContainerView.backgroundColor = incorrect ? UIColor.red : UIColor.white
            self.inputTextField.textColor = incorrect ? UIColor.white : UIColor.black
        }, completion: nil)
        
    }
    
    @objc func updateCounter() {
        seconds = seconds + 1
        wordsPerMinute = (currentCharacterIndex/5 * 60)/(seconds)
    }
    
    func addShadow(view: UIView) {
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowPath = shadowPath.cgPath
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputString = string
        
        if (inputString.count != 0) {
            // mark as incorrect despite input
            if (incorrectInput == true) {
                if (currentCharacterIndex - incorrectInputIndex > 5) {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
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
                if (currentCharacterIndex == excerptLabel.text!.count - 1) {
                    print("finished")
                    return true
                }
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
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.race_blueColor(), range: colorRange)
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
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
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


