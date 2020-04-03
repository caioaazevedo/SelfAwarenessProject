import Foundation
import SpriteKit

public class GameScene: SKScene {
    
//MARK: - Atributos da Cena
    
    var background = Background()
    var background2 = Background()
    var background3 = Background()
    var player = Player()
    var clonePlayer = Clone()

    var bigWall = BigWall()
    var mediumWall = MediumWall()
    var smallWall = SmallWall()

    var ground = Ground()

    var controls = Control()

    var backgroundMusic = SKAudioNode()
    var damageSound = SKAudioNode()
    var breakingMirrorSound = SKAudioNode()

    var gameText = GameText()

    var gameCamera = SKCameraNode()

    var invisibleWall = InvisibleWall()
    var mirror = Mirror()
    var trueVisionPower = Power()
    
    var invisibleWallCount = 0
    
    /// Flags
    var cloneCreated = false
    var gotPowerVision = false
    var mirrorCrached = false
    var beginFrases = false
    var updateePosition = false
    var fowardsBtn = false
    var backwardsBtn = false
    
    public override func didMove(to view: SKView) {
        /// Adição da música na Cena em loop infinito
        backgroundMusic = SKAudioNode(fileNamed: "Sounds/Acústico.m4a")
        backgroundMusic.run(SKAction.changeVolume(to: 0.1, duration: 0))
        backgroundMusic.autoplayLooped = true

        addChild(backgroundMusic)

        damageSound = SKAudioNode(fileNamed: "Sounds/Damage.wav")
        breakingMirrorSound = SKAudioNode(fileNamed: "Sounds/GlassBroken.mp3")

        ///
        gameCamera = SKCameraNode()
        self.camera = gameCamera
        gameCamera.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(gameCamera)

        /// Adicinando o Background em toda a extensão da cena
        background = Background(scene: self, positionX: -(self.size.width/2))
        background2 = Background(scene: self, positionX: background.size.width-(self.size.width/2))
        background3 = Background(scene: self, positionX: background2.position.x + background2.size.width)
        addChild(background)
        addChild(background2)
        addChild(background3)

        /// Adição dos Obstáculos na Cena
        bigWall = BigWall(scene: self)
        addChild(bigWall)

        mediumWall = MediumWall(scene: self)
        addChild(mediumWall)

        smallWall = SmallWall(scene: self)
        addChild(smallWall)

        /// Adição das Paredes Invisíveis para mudaça de texto da Label
        invisibleWall = InvisibleWall(scene: self)
        addChild(invisibleWall.invisibleWall)

        /// Adição do espelho invisível
        mirror = Mirror(scene: self, smallWall: smallWall)
        addChild(mirror.mirror)

        /// Adição do Player na cena
        player = Player(scene: self)
        addChild(player)

        /// Adição do Clone na cena
        clonePlayer = Clone(scene: self, smallWall: smallWall)
        addChild(clonePlayer)

        controls = Control(scene: self)

        gameText = GameText(scene: self)

        trueVisionPower = Power(scene: self, bigWall: bigWall)
        addChild(trueVisionPower.trueVisionPower)

        /// Configuração da física do jogo e delimitação da área sujeita a física
        self.physicsWorld.contactDelegate = self

        let posY = self.size.height*0.275
        let widthBody = self.size.width*3
        let heightBody = self.size.height*0.85

        let sceneRect = CGRect(x: 0, y: posY, width: widthBody, height: heightBody)

        /// Seta o physics Body da cena - O edge loop determina um corpo estático, não move e nem colide
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: sceneRect)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
    }
    
//    public override init(size: CGSize) {
//        super.init()
//        self.size = size
//        
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//MARK: - Movimento
    /// Método responsável por identificar o início do toque do ususário
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50), at: player.position)
            }
            
        }
        self.updateePosition = true
    }

    /// Método responsável por identificar o final do toque do ususário
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    override public func update(_ currentTime: TimeInterval) {
        if updateePosition && fowardsBtn {
            player.physicsBody?.applyImpulse(CGVector(dx: +5, dy: 0), at: player.position)
            
        } else if updateePosition && backwardsBtn {
            player.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0), at: player.position)
        }
        
        /// Atualiza a posição da Câmera, dos botões e do texto na cena
        gameCamera.position.x = player!.position.x + self.size.width * 0.15
        controls.btnBackwards.position = CGPoint(x: gameCamera.position.x-self.size.width*0.4, y: self.size.height*0.1)
        controls.btnFowards.position = CGPoint(x: gameCamera.position.x-self.size.width*0.3, y: self.size.height*0.1)
        controls.btnJump.position = CGPoint(x: gameCamera.position.x-self.size.width*0.2, y: self.size.height*0.1)
        gameText.textLabel.position = CGPoint(x: gameCamera.position.x-self.size.width*0.25, y: self.size.height*0.9)
        gameText.textLabelLine2.position = CGPoint(x: gameCamera.position.x-self.size.width*0.25, y: self.size.height*0.83)
        
        if !mirrorCrached {
            clonePlayer.position = CGPoint(x: smallWall.position.x + (smallWall.position.x - player.position.x), y: player.position.y)
            clonePlayer.zRotation = -player.zRotation
        }
        
        if player.intersects(invisibleWall.invisibleWall) {
            
            switch invisibleWallCount {
            case 0:
                invisibleWall.invisibleWall.removeFromParent()
                changeText(msgTxt1: gameText.textValues["text2"]!, msgTxt2: "", color: .brown, timeWait: nil, completion: nil)
                invisibleWallCount += 1

                invisibleWall.invisibleWall.position = CGPoint(x: 1000, y:0)
                addChild(invisibleWall.invisibleWall)
            case 1:
                invisibleWall.invisibleWall.removeFromParent()

                changeText(msgTxt1: gameText!.textValues["text3"], msgTxt2: "", color: .brown, timeWait: nil, completion: nil)
                invisibleWallCount += 1
            default:
                print("nothing")
            }
            
        }
    }
    
    func changeText(msgTxt1: String, msgTxt2: String, color: SKColor, timeWait: TimeInterval?, completion: (() -> ())?) {
        let actionFadeOut = SKAction.fadeOut(withDuration: 1)
        let actionFadeIn = SKAction.fadeIn(withDuration: 1)
        
        gameText.textLabelLine2.run(actionFadeOut)
        gameText.textLabel.run(actionFadeOut){
            self.gameText.textLabel.text = msgTxt1
            self.gameText.textLabel.fontSize = 35
            self.gameText.textLabel.fontColor = color
            
            self.gameText.textLabelLine2.text = msgTxt2
            self.gameText.textLabelLine2.fontSize = 35
            self.gameText.textLabelLine2.fontColor = color
            
            if let time = timeWait {
                let wait = SKAction.wait(forDuration: time)
                let sequence = SKAction.sequence([actionFadeIn, wait])
                self.gameText.textLabelLine2.run(actionFadeIn)
                self.gameText.textLabel.run(sequence){
                guard let completion = completion else { return }
                    completion()
                }
            } else {
                self.gameText.textLabel.run(actionFadeIn)
                self.gameText.textLabelLine2.run(actionFadeIn)
                guard let completion = completion else { return }
                completion()
            }
        }
    }
    
    func damege(node: SKSpriteNode){
        let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.05)
        
        let sequence = SKAction.sequence([colorize, SKAction.wait(forDuration: 0.2),colorize.reversed()])
        
        node.run(sequence)
        
        addChild(damageSound!)
        
        damageSound.run(SKAction.changeVolume(to: 0.3, duration: 0))
        damageSound.run(SKAction.wait(forDuration: 0.5)){
            self.damageSound.removeFromParent()
        }
        
    }
    
}

//MARK: - Colisão
extension GameScene: SKPhysicsContactDelegate{
    public func didBegin(_ contact: SKPhysicsContact) {
        //Verifica o contato
        if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "mirror" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "mirror"{
            
            damege(node: player!)
            
            if invisibleWallCount == 2 {
                changeText(msgTxt1: gameText.textValues["text4"]!, msgTxt2: gameText.textValues["text4_2"]!, color: .brown, timeWait: nil, completion: nil)
                addChild(trueVisionPower.trueVisionPower)
                invisibleWallCount = -1
            } else if gotPowerVision  && !beginFrases{
                
                changeText(msgTxt1: gameText.textValues["text6"]!, msgTxt2: gameText!.textValues["text6_2"]!, color: .white, timeWait: 3) {
                    self.changeText(msgTxt1: self.gameText.textValues["text7"]!, msgTxt2: self.gameText.textValues["text7_2"]!, color: .white, timeWait: 3) {
                        self.changeText(msgTxt1: self.gameText.textValues["text8"]!, msgTxt2: self.gameText.textValues["text8_2"]!, color: .white, timeWait: 3) {
                            self.changeText(msgTxt1: self.gameText.textValues["text9"]!, msgTxt2: self.gameText.textValues["text9_2"]!, color: .white, timeWait: 3) {
                                self.changeText(msgTxt1: self.gameText.textValues["text10"]!, msgTxt2: self.gameText.textValues["text10_2"]!, color: .white, timeWait: 3) {
                                    self.changeText(msgTxt1: self.gameText.textValues["text11"]!, msgTxt2: self.gameText.textValues["text11_2"]!, color: .white, timeWait: 3) {
                                        self.changeText(msgTxt1: self.gameText.textValues["text12"]!, msgTxt2: self.gameText.textValues["text12_2"]!, color: .white, timeWait: 3){
                                            self.player!.run(SKAction.fadeOut(withDuration: 1)){
                                                self.player.texture = SKTexture(imageNamed: "Assets/PlayerBall_Titanium")
                                                self.player.setScale(1.5)
                                                self.player.run(SKAction.fadeIn(withDuration: 1))
                                                self.changeText(msgTxt1: self.gameText.textValues["text13"]!, msgTxt2: self.gameText.textValues["text13_2"]!, color: .white, timeWait: 3){
                                                    self.changeText(msgTxt1: self.gameText.textValues["text14"]!, msgTxt2: self.gameText.textValues["text14_2"]!, color: .white, timeWait: 3){
                                                        
                                                    }
                                                }
                                            }
                                            self.clonePlayer.run(SKAction.fadeAlpha(by: 0.2, duration: 1))
                                            self.mirror.mirror.removeFromParent()
                                            self.addChild(self.breakingMirrorSound)
                                            self.mirrorCrached = true
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                beginFrases = true
            }
            
        } else if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "trueVisionPower" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "trueVisionPower" {
            
            if !gotPowerVision {
                let fadeOut = SKAction.fadeOut(withDuration: 1)
                let fadeIn = SKAction.fadeIn(withDuration: 1)
                trueVisionPower.trueVisionPower.physicsBody = nil
                
                trueVisionPower.trueVisionPower.run(fadeOut){
                    self.trueVisionPower.trueVisionPower.removeFromParent()
                }
                background.run(fadeOut)
                background3.run(fadeOut)
                background2.run(fadeOut){
                    
                    self.background.texture = SKTexture(imageNamed: "Assets/Background_Color")
                    self.background2.texture = SKTexture(imageNamed: "Assets/Background_Color")
                    self.background3.texture = SKTexture(imageNamed: "Assets/Background_Color")
                    self.background.run(fadeIn)
                    self.background2.run(fadeIn)
                    self.background3.run(fadeIn)
                    
                    self.smallWall.texture = SKTexture(imageNamed: "Assets/SmallWall_Color")
                    self.mediumWall.texture = SKTexture(imageNamed: "Assets/MediumWall_Color")
                    self.bigWall.texture = SKTexture(imageNamed: "Assets/BigWall_Color")
                    self.smallWall.run(fadeIn)
                    self.mediumWall.run(fadeIn)
                    self.bigWall.run(fadeIn)
                }
                
                changeText(msgTxt1: gameText.textValues["text5"]!, msgTxt2: gameText.textValues["text5_2"]!, color: .white, timeWait: 0, completion: nil)
                
                clonePlayer.run(fadeIn){
                    self.clonePlayer.alpha = 1.0
                }
                
                gotPowerVision = true
            }
        }
            print("a: \(contact.bodyA.node?.name ?? "nada"), B: \(contact.bodyB.node?.name ?? "nada")")
            
    }
}