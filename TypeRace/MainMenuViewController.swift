//
//  MainMenuViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/19/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit
import GameKit

class MainMenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topSpeedLabel: UILabel!
    @IBOutlet weak var topSpeedContainerView: UIView!
    
    var gameCenterEnabled = Bool()
    var gameCenterLeaderboardID = String()
    let leaderboardID = "com.score.typerace"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        authenticateLocalPlayer()
    }
    
    @IBAction func leaderboardButtonPressed(_ sender: Any) {
        showLeaderboardViewController()
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
        topSpeedContainerView.layer.cornerRadius = topSpeedContainerView.frame.width/2
        addShadow(view: topSpeedContainerView)
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
  
    // MARK: dGame Center
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                self.gameCenterEnabled = true
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        self.gameCenterLeaderboardID = leaderboardIdentifer!
                    }
                })
            } else {
                self.gameCenterEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
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
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addShadow(view: UIView) {
        let shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.frame.width/2)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowPath = shadowPath.cgPath
    }
    
}
