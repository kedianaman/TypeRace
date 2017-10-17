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
    
    var time: Int!
    var wpm: Int!
    var accuracy: Int! 
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(time)
        wpmLabel.text = String(wpm)
        accuracyLabel.text = String(accuracy)
    }


   
}

