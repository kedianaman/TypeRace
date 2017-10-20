//
//  MainMenuViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/19/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var topSpeedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup() {
        self.view.backgroundColor = UIColor.race_bgGreyColor()
        let typeFont = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.light)
        let raceFont = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        let titleText = NSMutableAttributedString(string: "Type", attributes: [NSAttributedStringKey.font: typeFont])
        titleText.append(NSMutableAttributedString(string: "R", attributes: [NSAttributedStringKey.font: raceFont, NSAttributedStringKey.foregroundColor: UIColor.race_blueColor()]))
        titleText.append(NSMutableAttributedString(string: "A", attributes: [NSAttributedStringKey.font: raceFont, NSAttributedStringKey.foregroundColor: UIColor.race_pinkColor()]))
        titleText.append(NSMutableAttributedString(string: "C", attributes: [NSAttributedStringKey.font: raceFont, NSAttributedStringKey.foregroundColor: UIColor.race_greenColor()]))
        titleText.append(NSMutableAttributedString(string: "E", attributes: [NSAttributedStringKey.font: raceFont, NSAttributedStringKey.foregroundColor: UIColor.race_orangeColor()]))
        titleLabel.attributedText = titleText
        var topSpeed = 0;
        
        if let topWPM = UserDefaults.standard.value(forKey: "topWPM") as? Int {
            topSpeed = topWPM
        }
        topSpeedLabel.clipsToBounds = true
        topSpeedLabel.layer.cornerRadius = topSpeedLabel.frame.width/2
        let numberFont = UIFont.systemFont(ofSize: 70, weight: UIFont.Weight.bold)
        let subtitleFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        let topSpeedTitle = NSMutableAttributedString(string: String(topSpeed), attributes: [NSAttributedStringKey.font: numberFont])
        topSpeedTitle.append(NSMutableAttributedString(string: "\n TOP WPM", attributes: [NSAttributedStringKey.font: subtitleFont]))
        topSpeedLabel.attributedText = topSpeedTitle
    }
    
    @IBAction func unwindToMainMenuViewController(segue:UIStoryboardSegue) {
        // set score
        if let topWPM = UserDefaults.standard.value(forKey: "topWPM") as? Int {
            let numberFont = UIFont.systemFont(ofSize: 70, weight: UIFont.Weight.bold)
            let subtitleFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
            let topSpeedTitle = NSMutableAttributedString(string: String(topWPM), attributes: [NSAttributedStringKey.font: numberFont])
            topSpeedTitle.append(NSMutableAttributedString(string: "\n TOP WPM", attributes: [NSAttributedStringKey.font: subtitleFont]))
            topSpeedLabel.attributedText = topSpeedTitle
        }
    }
}
