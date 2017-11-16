//
//  MultiplayerGameViewController.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/26/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import UIKit
import GameKit
class MultiplayerGameViewController: UIViewController, GKMatchmakerViewControllerDelegate {
 
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        print("match cancelled")
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("match failed")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4

        let mmvc = GKMatchmakerViewController(matchRequest: request)!
        mmvc.matchmakerDelegate = self

        present(mmvc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
