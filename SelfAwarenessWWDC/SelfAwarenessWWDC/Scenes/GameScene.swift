//
//  GameScene.swift
//  SelfAwarenessWWDC
//
//  Created by Caio Azevedo on 24/03/20.
//  Copyright © 2020 Caio Azevedo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "Background_Mono")
    let player = SKSpriteNode(imageNamed: "BallPlayer")
    let wall = SKSpriteNode(imageNamed: "Wall")
    let btnBackwards = SKShapeNode(circleOfRadius: 70)
    let btnFowards = SKShapeNode(circleOfRadius: 70)
    let backgroundMusic = SKAudioNode(fileNamed: "Acústico.m4a")
    
    override func didMove(to view: SKView) {
        
        addChild(background)
        
//        addChild(backgroundMusic)
        
        backgroundMusic.autoplayLooped = true
        
        /// Anchor Point Zero - significa que o ponto de ancoragem do sprite é o canto Inferior Esquerdo dele
        background.anchorPoint = CGPoint.zero
        
        /// Posicionar o sprite na posição Zero indica que ele sra posicionado no (0,0) canto Inferior Esquerdo
        background.position = CGPoint.zero
        background.size = CGSize(width: self.size.width, height: self.size.height)
        
        background.zPosition = -1
        
        /// Rotação e m relação a pi
        //background.zRotation = CGFloat.pi / 8
        
        /// Adição do Player
        addChild(player)
        
        player.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        player.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.35)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 146 Altura = 130
        /// Calculo Referente a Tela: Largura = 0.10689 Altura = 0.12695
        
        let playerWidth = self.size.width * 0.10689
        let playerHeight = self.size.height * 0.12695
        
        player.size = CGSize(width: playerWidth, height: playerHeight)
        
        /// Adição do Obstáculo
        
        addChild(wall)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 512,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let wallWidth = self.size.width * 0.10131
        let wallHeight = self.size.height * 0.50008
        
        wall.anchorPoint = CGPoint(x: 0.5, y: 0)
        wall.position = CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.35)
        
        wall.size = CGSize(width: wallWidth, height: wallHeight)
 
    }
    
    
    
}
