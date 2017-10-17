//
//  ResultsViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/16/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wpmLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var progressBarIndicator: UIView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    var time: Int!
    var wpm: Int!
    var accuracy: Int!
    var quote: Quote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.race_bgGreyColor()
        progressBarIndicator.layer.cornerRadius = 15
//        timeLabel.text = String(time)
//        wpmLabel.text = String(wpm)
//        accuracyLabel.text = String(accuracy)
        timeLabel.layer.cornerRadius = timeLabel.frame.width/2
        timeLabel.clipsToBounds = true
        wpmLabel.layer.cornerRadius = wpmLabel.frame.width/2
        wpmLabel.clipsToBounds = true
        accuracyLabel.layer.cornerRadius = accuracyLabel.frame.width/2
        accuracyLabel.clipsToBounds = true
        quoteLabel.text = "\(quote.quoteText!) - \(quote.quoteAuthor!)"
    }

    @IBAction func retryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGameID", sender: self)
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
    
    
   
}

