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
        
        player.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        player.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.35)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 146 Altura = 130
        /// Calculo Referente a Tela: Largura = 0.10689 Altura = 0.12695
        
        let playerWidth = self.size.width * 0.10689
        let playerHeight = self.size.height * 0.12695
        
        player.size = CGSize(width: playerWidth, height: playerHeight)
        
        /// Cria o corpo que receberá a aplicação da física - esse é o jeito mais performático
        player.physicsBody = SKPhysicsBody(circleOfRadius: playerWidth/2)
        
        // Adição do Player
        addChild(player)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 512,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let wallWidth = self.size.width * 0.10131
        let wallHeight = self.size.height * 0.50008
        
        wall.anchorPoint = CGPoint(x: 0.5, y: 0)
        wall.position = CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.35)
        
        wall.size = CGSize(width: wallWidth, height: wallHeight)
        
        /// Adição do Obstáculo
        addChild(wall)
        
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
            player.position.x = player.position.x+7
        } else if updateePosition && backwardsBtn && player.position.x > self.size.width*0.07{
            player.position.x = player.position.x-7
        }
    }
    
    
    
}
