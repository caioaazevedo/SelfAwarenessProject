//
//  GameScene.swift
//  SelfAwarenessWWDC
//
//  Created by Caio Azevedo on 24/03/20.
//  Copyright © 2020 Caio Azevedo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "PlanoFundo_Mono")
    let player = SKSpriteNode(imageNamed: "BallPlayer")
    let wall = SKSpriteNode(imageNamed: "Wall")
    var ground = SKShapeNode()
    let btnBackwards = SKShapeNode(circleOfRadius: 50)
    let btnFowards = SKShapeNode(circleOfRadius: 50)
    let btnJump = SKShapeNode(circleOfRadius: 50)
    let backgroundMusic = SKAudioNode(fileNamed: "Acústico.m4a")
    
    var updateePosition = false
    var fowardsBtn = false
    var backwardsBtn = false
    
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
        
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        player.position = CGPoint(x: self.size.width * 0.35, y: self.size.height * 0.5)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 117 Altura = 123
        /// Calculo Referente a Tela: Largura = 0.10689 Altura = 0.12695
        
        let playerWidth = self.size.width * 0.095651
        let playerHeight = self.size.height * 0.13011
        
        player.size = CGSize(width: playerWidth, height: playerHeight)
        
        /// Cria o corpo que receberá a aplicação da física - esse é o jeito mais performático
        player.physicsBody = SKPhysicsBody(circleOfRadius: playerWidth/2)
        
        // Adição do Player
        addChild(player)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 512,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let wallWidth = self.size.width * 0.10131
        let wallHeight = self.size.height * 0.47508
        
        wall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        wall.position = CGPoint(x: self.size.width * 0.55, y: self.size.height*0.6)
        
        wall.size = CGSize(width: wallWidth, height: wallHeight)
        
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.frame.size)
        wall.physicsBody?.isDynamic = false
        
        /// Adição do Obstáculo
        addChild(wall)
        
        ///Adicionando o chão
        ground = SKShapeNode(rect: CGRect(x: 0, y: self.size.height*0.35, width: self.frame.width, height: 5))
        
//        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeLoopFrom: ground.frame)
        ground.physicsBody?.restitution = 0.5
        ground.physicsBody?.isDynamic = false
        ground.alpha = 1.0
        
        addChild(ground)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
        ///Adição do botão de movimento para  trás
        btnBackwards.fillColor = .blue
        btnBackwards.position = CGPoint(x: self.size.width*0.1, y: self.size.height*0.1)
        
        addChild(btnBackwards)
        
        ///Da um nome ao botao, como uma espécie de identificador
        btnBackwards.name = "backwards"
        
        ///Adição do botão de movimento para  frente
        btnFowards.fillColor = .red
        btnFowards.position = CGPoint(x: self.size.width*0.2, y: self.size.height*0.1)
        
        addChild(btnFowards)
        
        btnFowards.name = "fowards"
        
       ///Adição do botão de movimento para  frente
       btnJump.fillColor = .green
       btnJump.position = CGPoint(x: self.size.width*0.3, y: self.size.height*0.1)
       
       addChild(btnJump)
       
       btnJump.name = "jump"
        
        
    }
    
    /// Método responsável por identificar o início do toque do ususário
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ///Percorre o Array para obter a localização do toque e por meio desta identificar o node que foi tocado
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            ///Verificação do node tocado com o nome identificador do botão
            if node.name == "backwards" {
                backwardsBtn = true
            } else if node.name == "fowards"{
                fowardsBtn = true
            } else if node.name == "jump" {
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500), at: player.position)
            }
            
        }
        self.updateePosition = true
    }

    /// Método responsável por identificar o final do toque do ususário
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ///Percorre o Array para obter a localização do toque e por meio desta identificar o node que foi tocado
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            ///Verificação do node tocado com o nome identificador do botão
            if node.name == "backwards" {
                backwardsBtn = false
            } else if node.name == "fowards"{
                fowardsBtn = false
            }
        }
        self.updateePosition = false
    }

    ///Método responsável por atualização de tela - Executa 60 vezes por segundo (60 FPS)
    override func update(_ currentTime: TimeInterval) {
        if updateePosition && fowardsBtn && player.position.x < self.size.width*0.93 {
            player.physicsBody?.applyImpulse(CGVector(dx: +10, dy: 0), at: player.position)
        } else if updateePosition && backwardsBtn && player.position.x > self.size.width*0.07{
            player.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0), at: player.position)
        }
    }
    
    
    
}
