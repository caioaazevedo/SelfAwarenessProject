//
//  GameScene.swift
//  SelfAwarenessWWDC
//
//  Created by Caio Azevedo on 24/03/20.
//  Copyright © 2020 Caio Azevedo. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
//MARK: - Atributos Nodes
    
    let background = SKSpriteNode(imageNamed: "Background_Mono")
    let background2 = SKSpriteNode(imageNamed: "Background_Mono")
    let background3 = SKSpriteNode(imageNamed: "Background_Mono")
    
    let player = SKSpriteNode(imageNamed: "BallPlayer")
    let clonePlayer = SKSpriteNode(imageNamed: "BallPlayer")
    
    let bigWall = SKSpriteNode(imageNamed: "BigWall")
    let mediumWall = SKSpriteNode(imageNamed: "MediumWall")
    let smallWall = SKSpriteNode(imageNamed: "SmallWall")
    
    var ground = SKShapeNode()
    
    let btnBackwards = SKShapeNode(circleOfRadius: 50)
    let btnFowards = SKShapeNode(circleOfRadius: 50)
    let btnJump = SKShapeNode(circleOfRadius: 50)
    
    let backgroundMusic = SKAudioNode(fileNamed: "Acústico.m4a")
    
    let textLabel = SKLabelNode(fontNamed: "Helvetica")
    let textLabelLine2 = SKLabelNode(fontNamed: "Helvetica")
    
    let cameraNode = SKCameraNode()
    
    var invisibleWall = SKShapeNode()
    var mirror = SKShapeNode()
    var trueVisionPower = SKShapeNode(circleOfRadius: 50)
    
    var invisibleWallCount = 0
    var cloneCreated = false
    var gotPowerVision = false
    var mirrorCrached = false
    
    /// Constantes de texto
    let text1 = "Sometimes in life you have obstacles"
    let text1_2 = "that you need to go through"
    
    let text2 = "Some are more difficult than others"
    
    let text3 = "But sometimes..."
    
    let text4 = "You just can't get through"
    let text4_2 = "But why?"
    
    let text5 = "TRUE VISION"
    let text5_2 = "Allows you to see what you couldn't"
    
    let text6 = "This is what really happens"
    
    
    /// Flags
    var updateePosition = false
    var fowardsBtn = false
    var backwardsBtn = false

    override func didMove(to view: SKView) {

        addChild(background)
        
//MARK: - Gravidade
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
//MARK: - Música
        backgroundMusic.run(SKAction.changeVolume(to: 0.1, duration: 0))
        addChild(backgroundMusic)
        
        backgroundMusic.autoplayLooped = true
        
//MARK: - Câmera
        addChild(cameraNode)
        self.camera = cameraNode
        cameraNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)

//MARK: - Ground
        ///Adicionando o chão
        ground = SKShapeNode(rect: CGRect(x: 0, y: self.size.height*0.35, width: 5000, height: 5))
        
//        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeLoopFrom: ground.frame)
        ground.physicsBody?.restitution = 0.5
        ground.physicsBody?.isDynamic = false
        ground.alpha = 1.0
        ground.name = "Ground"
        
        addChild(ground)
        
//MARK: - Background
        /// Anchor Point Zero - significa que o ponto de ancoragem do sprite é o canto Inferior Esquerdo dele
        background.anchorPoint = CGPoint.zero
        
        /// Posicionar o sprite na posição Zero indica que ele sra posicionado no (0,0) canto Inferior Esquerdo
        background.position = CGPoint(x: -(self.size.width/2), y: 0)
        background.size = CGSize(width: 2374, height: 1024)
        
        background.zPosition = -1
        
        /// Anchor Point Zero - significa que o ponto de ancoragem do sprite é o canto Inferior Esquerdo dele
        background2.anchorPoint = CGPoint.zero
        
        /// Posicionar o sprite na posição Zero indica que ele sra posicionado no (0,0) canto Inferior Esquerdo
        background2.position = CGPoint(x: background.size.width-(self.size.width/2), y: 0)
        background2.size = CGSize(width: 2374, height: 1024)
        
        background2.zPosition = -1
        
        addChild(background2)
        
        /// Anchor Point Zero - significa que o ponto de ancoragem do sprite é o canto Inferior Esquerdo dele
        background3.anchorPoint = CGPoint.zero

        /// Posicionar o sprite na posição Zero indica que ele sra posicionado no (0,0) canto Inferior Esquerdo
        background3.position = CGPoint(x: background2.position.x + background2.size.width, y: 0)
        background3.size = CGSize(width: 2374, height: 1024)

        background3.zPosition = -1

        addChild(background3)
        //MARK: - Wall
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 512,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let bigWallWidth = self.size.width * 0.10131
        let bigWallHeight = self.size.height * 0.47508
        
        bigWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bigWall.position = CGPoint(x: 2300, y: self.size.height*0.6)
        
        bigWall.size = CGSize(width: bigWallWidth, height: bigWallHeight)
        
        bigWall.physicsBody = SKPhysicsBody(rectangleOf: bigWall.frame.size)
        bigWall.physicsBody?.isDynamic = false
        
        /// Adição do Obstáculo
        addChild(bigWall)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 218,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let mediumWallWidth = self.size.width * 0.101024
        let mediumWallHeight = self.size.height * 0.212890
        
        mediumWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mediumWall.position = CGPoint(x: self.size.width * 0.55, y: self.size.height*0.45)
        
        mediumWall.size = CGSize(width: mediumWallWidth, height: mediumWallHeight)
        
        mediumWall.physicsBody = SKPhysicsBody(rectangleOf: mediumWall.frame.size)
        mediumWall.physicsBody?.isDynamic = false
        
        /// Adição do Obstáculo
        addChild(mediumWall)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 134,45 Altura = 112,61
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008

        let smallWallWidth = self.size.width * 0.098096
        let smallWallHeight = self.size.height * 0.109970

        smallWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        smallWall.position = CGPoint(x: 4000, y: self.size.height*0.4)

        smallWall.size = CGSize(width: smallWallWidth, height: smallWallHeight)

        smallWall.physicsBody = SKPhysicsBody(rectangleOf: smallWall.frame.size)
        smallWall.physicsBody?.isDynamic = false

        /// Adição do Obstáculo
        addChild(smallWall)
                
        
//MARK: - Parede invisível
        let posX = self.size.width
        invisibleWall = SKShapeNode(rect: CGRect(x: posX, y: 0, width: 0, height: self.size.height))
        invisibleWall.physicsBody = SKPhysicsBody(edgeLoopFrom: invisibleWall.frame)
        invisibleWall.alpha = 1.0
        invisibleWall.name = "invisibleWall"
        invisibleWall.fillColor = .blue
        invisibleWall.physicsBody?.collisionBitMask = 0b0001
       
        addChild(invisibleWall)
       
        let positionX = smallWall.position.x
       
        mirror = SKShapeNode(rect: CGRect(x: positionX, y: 0, width: 0, height: self.size.height))
        mirror.physicsBody = SKPhysicsBody(edgeLoopFrom: mirror.frame)
        mirror.physicsBody?.isDynamic = false
        mirror.physicsBody?.restitution = 0.8
        mirror.alpha = 1.0
        mirror.name = "mirror"
        mirror.fillColor = .blue
        mirror.physicsBody?.collisionBitMask = 0b0001
        addChild(mirror)
        
//MARK: - Player
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        player.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.5)
        
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 117 Altura = 123
        /// Calculo Referente a Tela: Largura = 0.10689 Altura = 0.12695
        
        let playerWidth = self.size.width * 0.095651
        let playerHeight = self.size.height * 0.13011
        
        player.size = CGSize(width: playerWidth, height: playerHeight)
        
        /// Cria o corpo que receberá a aplicação da física - esse é o jeito mais performático
        player.physicsBody = SKPhysicsBody(circleOfRadius: (playerWidth/2)-10)
        player.name = "player"
        player.physicsBody!.contactTestBitMask = 0b0001
        
        // Adição do Player
        addChild(player)
        
//MARK: - Clone Player
        // Criação do clone do player
        clonePlayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        /// A posição do Clone se da pela diferença entre o muro pequeno e o player somada a posição do muro
//        let clonePositionX = (smallWall.position.x - player.position.x) + smallWall.position.x
        clonePlayer.position = CGPoint(x: smallWall.position.x + self.size.width*0.2, y: player.position.y)
        
        clonePlayer.size = player.size
        clonePlayer.alpha = 0
        
        addChild(clonePlayer)
       
//MARK: - Botões
        ///Adição do botão de movimento para  trás
        btnBackwards.fillColor = .blue
        btnBackwards.position = CGPoint(x: cameraNode.position.x+self.size.width*0.1, y: self.size.height*0.1)
        
        addChild(btnBackwards)
        
        ///Da um nome ao botao, como uma espécie de identificador
        btnBackwards.name = "backwards"
        
        ///Adição do botão de movimento para  frente
        btnFowards.fillColor = .red
        btnFowards.position = CGPoint(x: cameraNode.position.x+self.size.width*0.2, y: self.size.height*0.1)
        
        addChild(btnFowards)
        
        btnFowards.name = "fowards"
        
        ///Adição do botão de movimento para  frente
        btnJump.fillColor = .green
        btnJump.position = CGPoint(x: cameraNode.position.x+self.size.width*0.3, y: self.size.height*0.1)

        addChild(btnJump)

        btnJump.name = "jump"

//MARK: - Label Texto
        ///Configuração e adição do texto na Tela
        
        let showText = SKAction.fadeIn(withDuration: 1)
        textLabel.text = text1
        textLabel.fontSize = 35
        textLabel.fontColor = SKColor.brown
        textLabel.position = CGPoint(x: self.frame.size.width*0.25, y: self.size.height*0.9)
        
        textLabelLine2.text = text1_2
        textLabelLine2.fontSize = 35
        textLabelLine2.fontColor = SKColor.brown
        textLabelLine2.position = CGPoint(x: self.frame.size.width*0.25, y: self.size.height*0.85)

        addChild(textLabel)
        addChild(textLabelLine2)
        
        textLabel.run(showText)
        textLabelLine2.run(showText)
        
//MARK: - Power
        trueVisionPower.position = CGPoint(x: bigWall.position.x + self.size.width*0.6, y: self.size.height*0.4)
        trueVisionPower.fillColor = .blue
        trueVisionPower.name = "trueVisionPower"
        trueVisionPower.physicsBody = SKPhysicsBody(circleOfRadius: trueVisionPower.frame.size.width/2)
        trueVisionPower.physicsBody?.isDynamic = false
        
        
    }
    
//MARK: - Movimento
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
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400), at: player.position)
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
        if updateePosition && fowardsBtn {
            player.physicsBody?.applyImpulse(CGVector(dx: +10, dy: 0), at: player.position)
            
        } else if updateePosition && backwardsBtn {
            player.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0), at: player.position)
        }
        
        /// Atualiza a posição da Câmera, dos botões e do texto na cena
        cameraNode.position.x = player.position.x + self.size.width * 0.15
        btnBackwards.position = CGPoint(x: cameraNode.position.x-self.size.width*0.4, y: self.size.height*0.1)
        btnFowards.position = CGPoint(x: cameraNode.position.x-self.size.width*0.3, y: self.size.height*0.1)
        btnJump.position = CGPoint(x: cameraNode.position.x-self.size.width*0.2, y: self.size.height*0.1)
        textLabel.position = CGPoint(x: cameraNode.position.x-self.size.width*0.25, y: self.size.height*0.9)
        textLabelLine2.position = CGPoint(x: cameraNode.position.x-self.size.width*0.25, y: self.size.height*0.83)
        
        if !mirrorCrached {
            clonePlayer.position = CGPoint(x: smallWall.position.x + (smallWall.position.x - player.position.x), y: player.position.y)
            clonePlayer.zRotation = -player.zRotation
        }
    }
    
}

//MARK: - Colisão
extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        //Verifica o contato
        if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "invisibleWall" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "invisibleWall" {

            switch invisibleWallCount {
            case 0:
                print(contact.contactPoint)
                contact.bodyA.node?.removeFromParent()

                changeText(msgTxt1: text2, msgTxt2: "", color: .brown)
                invisibleWallCount += 1

                invisibleWall.position = CGPoint(x: 2000, y:0)
                addChild(invisibleWall)
            case 1:
                contact.bodyA.node?.removeFromParent()

                changeText(msgTxt1: text3, msgTxt2: "", color: .brown)
                invisibleWallCount += 1
            default:
                print("pass")
            }
        } else if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "mirror" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "mirror"{
            if invisibleWallCount == 2 {
                changeText(msgTxt1: text4, msgTxt2: text4_2, color: .brown)
                addChild(trueVisionPower)
                invisibleWallCount = -1
            } else if gotPowerVision {
                changeText(msgTxt1: text6, msgTxt2: "", color: .white)
            }
            
        } else if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "trueVisionPower" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "trueVisionPower" {
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let fadeIn = SKAction.fadeIn(withDuration: 1)
            trueVisionPower.physicsBody = nil
            
            trueVisionPower.run(fadeOut){
                self.trueVisionPower.removeFromParent()
            }
            background.run(fadeOut)
            background3.run(fadeOut)
            background2.run(fadeOut){
                
                self.background.texture = SKTexture(imageNamed: "Background_Color")
                self.background2.texture = SKTexture(imageNamed: "Background_Color")
                self.background3.texture = SKTexture(imageNamed: "Background_Color")
                self.background.run(fadeIn)
                self.background2.run(fadeIn)
                self.background3.run(fadeIn)
                
                self.smallWall.texture = SKTexture(imageNamed: "SmallWall_Color")
                self.mediumWall.texture = SKTexture(imageNamed: "MediumWall_Color")
                self.bigWall.texture = SKTexture(imageNamed: "BigWall_Color")
                self.smallWall.run(fadeIn)
                self.mediumWall.run(fadeIn)
                self.bigWall.run(fadeIn)
            }
            
            changeText(msgTxt1: text5, msgTxt2: text5_2, color: .white)
            
            clonePlayer.run(fadeIn){
                self.clonePlayer.alpha = 1.0
            }
            
            gotPowerVision = true
        }
            print("a: \(contact.bodyA.node?.name ?? "nada"), B: \(contact.bodyB.node?.name ?? "nada")")
            
    }
    
    func changeText(msgTxt1: String, msgTxt2: String, color: SKColor) {
        let actionFadeOut = SKAction.fadeOut(withDuration: 1)
        textLabel.run(actionFadeOut)
        textLabelLine2.run(actionFadeOut){
            self.textLabel.removeFromParent()
            self.textLabelLine2.removeFromParent()
            
            let actionFadeIn = SKAction.fadeIn(withDuration: 1)
            
            self.textLabel.text = msgTxt1
            self.textLabel.fontSize = 35
            self.textLabel.fontColor = color
            
            self.textLabelLine2.text = msgTxt2
            self.textLabelLine2.fontSize = 35
            self.textLabelLine2.fontColor = color
            
            self.addChild(self.textLabel)
            self.addChild(self.textLabelLine2)
            self.textLabel.run(actionFadeIn)
            self.textLabelLine2.run(actionFadeIn)
        }
    }
}
