//
//  RoundedCorner.swift
//  Social Mayhem
//
//  Created by Russell Brown on 14/04/2017.
//  Copyright © 2017 Russell Brown. All rights reserved.
//

import UIKit

class RoundedCorner: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 4.0
        
    }

}
