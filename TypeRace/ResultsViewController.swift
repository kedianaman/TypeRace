//
//  ResultsViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/16/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit
import GameKit

class ResultsViewController: UIViewController, GKGameCenterControllerDelegate {
 

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wpmLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var progressBarIndicator: UIView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    var time: Int!
    var wpm: Int!
    var accuracy: Int!
    var quote: Quote!
    let leaderboardID = "com.score.typerace"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        let defaults = UserDefaults.standard
        if let topWPM = defaults.value(forKey: "topWPM") as? Int {
            if wpm > topWPM {
                defaults.set(wpm, forKey: "topWPM")
                addScoreAndSubmit(topSpeed: wpm)
            }
        } else {
            defaults.set(wpm, forKey: "topWPM")
            addScoreAndSubmit(topSpeed: wpm)
        }
    }

    @IBAction func retryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGameID", sender: self)
    }
    @IBAction func leaderboardButtonPressed(_ sender: Any) {
        showLeaderboardViewController()
    }
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMainMenuSegueID", sender: self)
    }
    
    
    func initialSetUp() {
        view.backgroundColor = UIColor.race_bgGreyColor()
        progressBarIndicator.layer.cornerRadius = 15
        let numberFont = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        let subtitleFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        let timeText = NSMutableAttributedString(string: String(time), attributes: [NSAttributedStringKey.font: numberFont])
        timeText.append(NSMutableAttributedString(string: "\nSEC", attributes: [NSAttributedStringKey.font: subtitleFont]))
        timeLabel.attributedText = timeText
        let accuracyText = NSMutableAttributedString(string: String(accuracy), attributes: [NSAttributedStringKey.font: numberFont])
        accuracyText.append(NSMutableAttributedString(string: "\n%", attributes: [NSAttributedStringKey.font: subtitleFont]))
        let wpmNumberFont = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        let wpmText = NSMutableAttributedString(string: String(wpm), attributes: [NSAttributedStringKey.font: wpmNumberFont])
        wpmText.append(NSMutableAttributedString(string: "\nWPM", attributes: [NSAttributedStringKey.font: subtitleFont]))
        wpmLabel.attributedText = wpmText
        accuracyLabel.attributedText = accuracyText
        timeLabel.layer.cornerRadius = timeLabel.frame.width/2
        timeLabel.clipsToBounds = true
        wpmLabel.layer.cornerRadius = wpmLabel.frame.width/2
        wpmLabel.clipsToBounds = true
        accuracyLabel.layer.cornerRadius = accuracyLabel.frame.width/2
        accuracyLabel.clipsToBounds = true
        quoteLabel.text = "\(quote.quoteText!) - \(quote.quoteAuthor!)"
        addShadow(view: wpmLabel)
    }
    func addShadow(view: UIView) {
        let shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.bounds.width/2)
//        let shadowPath = UIBezierPath(rect: view.bounds)
//        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowPath = shadowPath.cgPath
    }
    
    // Game Center Code
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    func addScoreAndSubmit(topSpeed: Int) {
        let bestSpeedInt = GKScore(leaderboardIdentifier: leaderboardID)
        bestSpeedInt.value = Int64(topSpeed)
        GKScore.report([bestSpeedInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
    }
    
    func showLeaderboardViewController() {
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = leaderboardID
        present(gameCenterViewController, animated: true, completion: nil)
    }
    
    
   
}

