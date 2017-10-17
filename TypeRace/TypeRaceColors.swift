//
//  TypeRaceColors.swift
//  TypeRace
//
//  Created by Naman Kedia on 10/13/17.
//  Copyright © 2017 Naman Kedia. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func race_blueColor() -> UIColor {
        return UIColor(red: (62/255.0), green: (136/255.0), blue: (248/255.0), alpha: 1.0)
    }
    
    class func race_redColor() -> UIColor {
        return UIColor(red: (255/255.0), green: (59/255.0), blue: (48/255.0), alpha: 1.0)
    }
    
    class func race_redColorHighlight() -> UIColor {
        return UIColor(red: (255/255.0), green: (59/255.0), blue: (48/255.0), alpha: 0.6)
    }

    class func race_bgGreyColor() -> UIColor {
        return UIColor(red: (247/255.0), green: (247/255.0), blue: (247/255.0), alpha: 1.0)
    }
    
}

extension CGGradient {
    
    class func race_bgGradient() -> CAGradientLayer {
        let bgColorTop = UIColor(red: 247 / 255.0, green: 247 / 255.0, blue: 247 / 255.0, alpha: 1.0).cgColor
        let bgColorBottom = UIColor(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0).cgColor
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.colors = [bgColorTop, bgColorBottom]
        backgroundLayer.locations = [0.0, 1.0]
        return backgroundLayer
    }
    
    class func race_blueGradient() -> CAGradientLayer {
        let blueStart = UIColor(red: 25 / 255.0, green: 215 / 255.0, blue: 251 / 255.0, alpha: 1.0).cgColor
        let blueEnd = UIColor(red: 30 / 255.0, green: 99 / 255.0, blue: 238 / 255.0, alpha: 1.0).cgColor
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.colors = [blueStart, blueEnd]
        backgroundLayer.locations = [0.0, 1.0]
        return backgroundLayer
    }
    
}
