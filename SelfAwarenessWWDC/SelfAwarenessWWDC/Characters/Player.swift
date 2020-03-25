//
//  Player.swift
//  SelfAwarenessWWDC
//
//  Created by Caio Azevedo on 24/03/20.
//  Copyright © 2020 Caio Azevedo. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        // Do custom stuff here
        
    }

    // Swift requires this initializer to exist if you're adding any other custom ones
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
