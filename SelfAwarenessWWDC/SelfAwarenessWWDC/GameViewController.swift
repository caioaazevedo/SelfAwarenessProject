//
//  GameViewController.swift
//  SelfAwarenessWWDC
//
//  Created by Caio Azevedo on 24/03/20.
//  Copyright © 2020 Caio Azevedo. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size:CGSize(width: self.view.frame.width, height: self.view.frame.height))
        let skView = self.view as! SKView
        
        skView.showsFPS = true
//        skView.showsPhysics = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        
        let posY = scene.size.height*0.275
        let widthBody = scene.size.width
        let heightBody = scene.size.height*0.85

        let sceneRect = CGRect(x: 0, y: posY, width: 5000, height: heightBody)
        
        /// Seta o physics Body da cena - O edge loop determina um corpo estático, não move e nem colide
        scene.physicsBody = SKPhysicsBody(edgeLoopFrom: sceneRect)

        /// Zerar a gravidade
        //scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        skView.presentScene(scene)
       
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
