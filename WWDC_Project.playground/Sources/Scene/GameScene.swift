import Foundation
import SpriteKit

public class GameScene: SKScene {
    
//MARK: - Atributos da Cena
    
    var background = GameBackground()
    var background2 = GameBackground()
    var background3 = GameBackground()
    var player = Ball()
    var clonePlayer = Ball()

    var bigWall = BigWall()
    var mediumWall = MediumWall()
    var smallWall = SmallWall()

    var ground = Ground()
    var controls = Control()

    var backgroundMusic = SKAudioNode()
    var damageSound = SKAudioNode()
    var breakingMirrorSound = SKAudioNode()
    var powerRise = SKAudioNode()
    var backgroundFade = SKAudioNode()
    var transformAudio = SKAudioNode()

    var gameText = GameText()

    var gameCamera = SKCameraNode()

    var invisibleWall = SKShapeNode()
    var mirror = SKShapeNode()
    var trueVisionPower = Power()
    var titaniumPower = Power()
    
    var invisibleWallCount = 0
    
    /// Flags
    var cloneCreated = false
    var gotPowerVision = false
    var gotPowerTitanium = false
    var mirrorCrached = false
    var beginFrases = false
    var updateePosition = false
    var fowardsBtn = false
    var backwardsBtn = false
    var intersection = false
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        /// Adição da música na Cena em loop infinito
        backgroundMusic = SKAudioNode(fileNamed: "Sounds/Acústico.m4a")
        backgroundMusic.run(SKAction.changeVolume(to: 0.1, duration: 0))
        backgroundMusic.autoplayLooped = true

        powerRise = SKAudioNode(fileNamed: "Sounds/PowerRise.m4a")
        backgroundFade = SKAudioNode(fileNamed: "Sounds/BackgroudRise.m4a")
        damageSound = SKAudioNode(fileNamed: "Sounds/Damage.wav")
        breakingMirrorSound = SKAudioNode(fileNamed: "Sounds/MirrorBreakingSound.mp3")
        transformAudio = SKAudioNode(fileNamed: "Sounds/Transform.m4a")

        ///
        gameCamera = SKCameraNode()
        self.camera = gameCamera
        gameCamera.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(gameCamera)

        /// Adicinando o Background em toda a extensão da cena
        background = GameBackground(scene: self, positionX: -(self.size.width/2))
        background2 = GameBackground(scene: self, positionX: background.size.width-(self.size.width/2))
        background3 = GameBackground(scene: self, positionX: background2.position.x + background2.size.width)
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
        invisibleWall = SKShapeNode(rect: CGRect(x: self.size.width, y: 0, width: 0, height: self.size.height))
        invisibleWall.alpha = 0.0
        invisibleWall.name = "invisibleWall"
        invisibleWall.fillColor = .blue
        
        addChild(invisibleWall)

        /// Adição do espelho invisível
        let positionX = smallWall.position.x
        mirror = SKShapeNode(rect: CGRect(x: positionX, y: 0, width: 0, height: self.size.height))
        mirror.physicsBody = SKPhysicsBody(edgeLoopFrom: mirror.frame)
        mirror.physicsBody?.isDynamic = false
        mirror.physicsBody?.restitution = 0.8
        mirror.alpha = 0.0
        mirror.name = "mirror"
        mirror.fillColor = .blue
        mirror.physicsBody?.collisionBitMask = 0b0001
        addChild(mirror)

        /// Adição do Player na cena
        player = Ball(scene: self)
        player.physicsBody!.contactTestBitMask = 0b0001
        player.name = "player"
        addChild(player)

        /// Adição do Clone na cena
        clonePlayer = Ball(scene: self)
        let point = CGPoint(x: smallWall.position.x + self.size.width*0.2, y: player.position.y)
        clonePlayer.position = point
        clonePlayer.alpha = 0

        controls = Control(scene: self)

        gameText = GameText(scene: self)
        addChild(gameText.textLabel)
        addChild(gameText.textLabelLine2)
        
        trueVisionPower = Power(scene: self, bigWall: bigWall)
        
        titaniumPower = Power(scene: self, bigWall: bigWall)
        titaniumPower.texture = SKTexture(imageNamed: "Assets/TitaniumPower.png")
        titaniumPower.name = "titaniumPower"

        /// Configuração da física do jogo e delimitação da área sujeita a física
        self.physicsWorld.contactDelegate = self

        let posY = self.size.height*0.35
        let widthBody = self.size.width*4
        let heightBody = self.size.height*0.75

        let sceneRect = CGRect(x: 0, y: posY, width: widthBody, height: heightBody)
        
        addChild(backgroundMusic)

        /// Seta o physics Body da cena - O edge loop determina um corpo estático, não move e nem colide
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: sceneRect)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
    }
    
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
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 55), at: player.position)
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
            player.physicsBody?.applyImpulse(CGVector(dx: +2, dy: 0), at: player.position)
            
        } else if updateePosition && backwardsBtn {
            player.physicsBody?.applyImpulse(CGVector(dx: -2, dy: 0), at: player.position)
        }
        
        /// Atualiza a posição da Câmera, dos botões e do texto na cena
        gameCamera.position.x = player.position.x + self.size.width * 0.15
        controls.btnBackwards.position = CGPoint(x: gameCamera.position.x+self.size.width*0.2, y: self.size.height*0.1)
        controls.btnFowards.position = CGPoint(x: gameCamera.position.x+self.size.width*0.3, y: self.size.height*0.1)
        controls.btnJump.position = CGPoint(x: gameCamera.position.x+self.size.width*0.4, y: self.size.height*0.1)
        gameText.textLabel.position = CGPoint(x: gameCamera.position.x-self.size.width*0.15, y: self.size.height*0.9)
        gameText.textLabelLine2.position = CGPoint(x: gameCamera.position.x-self.size.width*0.15, y: self.size.height*0.83)
        
        if !mirrorCrached {
            clonePlayer.physicsBody = nil
        }
            
        if gotPowerVision {
            clonePlayer.position = CGPoint(x: smallWall.position.x + (smallWall.position.x - player.position.x), y: player.position.y)
            clonePlayer.zRotation = -player.zRotation
        }
        
        if player.intersects(invisibleWall) {
            
            switch invisibleWallCount {
            case 0:
                invisibleWall.removeFromParent()
                changeText(msgTxt1: gameText.textValues["text2"]!, msgTxt2: "", color: .brown, timeWait: nil, completion: nil)
                invisibleWallCount += 1

                invisibleWall.position = CGPoint(x: bigWall.position.x - (self.size.width*0.9), y:0)
                addChild(invisibleWall)
            case 1:
                invisibleWall.removeFromParent()

                changeText(msgTxt1: gameText.textValues["text3"]!, msgTxt2: "", color: .brown, timeWait: nil, completion: nil)
                invisibleWallCount += 1
            default:
                print("nothing")
            }
            
            if gotPowerTitanium {
                let finalScene = FinalScene(size: self.size)
                self.scene?.run(SKAction.fadeOut(withDuration: 1)){
                    self.view?.presentScene(finalScene)
                }
            }
            
        } else if (player.intersects(clonePlayer) && mirrorCrached) && !intersection{
            intersection = true
            breakingMirrorSound.run(SKAction.changeVolume(to: 0.5, duration: 0))
            addChild(breakingMirrorSound)
            breakingMirrorSound.run(SKAction.wait(forDuration: 1)){
                self.breakingMirrorSound.removeFromParent()
            }
            self.clonePlayer.run(SKAction.fadeOut(withDuration: 1)){
                self.clonePlayer.removeFromParent()
            }
        }
    }
    
    func changeText(msgTxt1: String, msgTxt2: String, color: SKColor, timeWait: TimeInterval?, completion: (() -> ())?) {
        let actionFadeOut = SKAction.fadeOut(withDuration: 1)
        let actionFadeIn = SKAction.fadeIn(withDuration: 1)
        
        gameText.textLabelLine2.run(actionFadeOut)
        gameText.textLabel.run(actionFadeOut){
            self.gameText.textLabel.text = msgTxt1
            self.gameText.textLabel.fontSize = 20
            self.gameText.textLabel.fontColor = color
            
            self.gameText.textLabelLine2.text = msgTxt2
            self.gameText.textLabelLine2.fontSize = 20
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
        
        addChild(damageSound)
        
        damageSound.run(SKAction.changeVolume(to: 0.5, duration: 0))
        damageSound.run(SKAction.wait(forDuration: 0.5)){
            self.damageSound.removeFromParent()
        }
        
    }
    
    func finalAct(){
        changeText(msgTxt1: gameText.textValues["text6"]!, msgTxt2: gameText.textValues["text6_2"]!, color: .white, timeWait: 3) {
            self.changeText(msgTxt1: self.gameText.textValues["text7"]!, msgTxt2: self.gameText.textValues["text7_2"]!, color: .white, timeWait: 3) {
               self.changeText(msgTxt1: self.gameText.textValues["text8"]!, msgTxt2: self.gameText.textValues["text8_2"]!, color: .white, timeWait: 3) {
                   self.changeText(msgTxt1: self.gameText.textValues["text9"]!, msgTxt2: self.gameText.textValues["text9_2"]!, color: .white, timeWait: 3) {
                       self.changeText(msgTxt1: self.gameText.textValues["text10"]!, msgTxt2: self.gameText.textValues["text10_2"]!, color: .white, timeWait: 3) {
                           self.changeText(msgTxt1: self.gameText.textValues["text11"]!, msgTxt2: self.gameText.textValues["text11_2"]!, color: .white, timeWait: 3) {
                               self.changeText(msgTxt1: self.gameText.textValues["text12"]!, msgTxt2: self.gameText.textValues["text12_2"]!, color: .white, timeWait: 3){
                                
                                    self.addChild(self.titaniumPower)
                                    
                                    self.powerRise.run(SKAction.changeVolume(to: 0.3, duration: 0))
                                    self.addChild(self.powerRise)
                                    self.powerRise.run(SKAction.wait(forDuration: 3)){
                                        self.powerRise.removeFromParent()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        beginFrases = true
    }
    
    func playerTransformation(){
        self.mirror.removeFromParent()
        self.mirrorCrached = true
        
        invisibleWall.position = CGPoint(x: self.smallWall.position.x, y: self.size.height*0.4)
        invisibleWall.fillColor = .blue
        addChild(invisibleWall)
        
        transformAudio.run(SKAction.changeVolume(to: 0.3, duration: 0))
        addChild(self.transformAudio)
        transformAudio.run(SKAction.wait(forDuration: 9)){
            self.transformAudio.removeFromParent()
        }
        
        let texture = SKTexture(imageNamed: "Assets/PlayerBall_Titanium")
        self.player.run(SKAction.setTexture(texture)){
               self.changeText(msgTxt1: self.gameText.textValues["text13"]!, msgTxt2: self.gameText.textValues["text13_2"]!, color: .white, timeWait: 3){
                   self.changeText(msgTxt1: self.gameText.textValues["text14"]!, msgTxt2: self.gameText.textValues["text14_2"]!, color: .white, timeWait: 3, completion: nil)
            }
        }
        self.player.run(SKAction.scale(by: 1.5, duration: 1))
        self.clonePlayer.run(SKAction.fadeAlpha(by: 0.2, duration: 1))
        
    }
    
    func changeScenario() {
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        trueVisionPower.physicsBody = nil
        
        trueVisionPower.run(fadeOut){
            self.trueVisionPower.removeFromParent()
        }
        
        background.run(fadeOut){
            self.background.texture = SKTexture(imageNamed: "Assets/Background_Color")
            self.background.run(fadeIn)
        }
        background2.run(fadeOut){
            self.background2.texture = SKTexture(imageNamed: "Assets/Background_Color")
            self.background2.run(fadeIn)
        }
        background3.run(fadeOut){
            self.background3.texture = SKTexture(imageNamed: "Assets/Background_Color")
            self.background3.run(fadeIn)
        }
        
        smallWall.run(fadeOut){
            self.smallWall.texture = SKTexture(imageNamed: "Assets/SmallWall_Color")
            self.smallWall.run(fadeIn)
        }
        mediumWall.run(fadeOut){
            self.mediumWall.texture = SKTexture(imageNamed: "Assets/MediumWall_Color")
            self.mediumWall.run(fadeIn)
        }
        bigWall.run(fadeOut){
            self.bigWall.texture = SKTexture(imageNamed: "Assets/BigWall_Color")
            self.bigWall.run(fadeIn)
        }
        
        backgroundFade.run(SKAction.changeVolume(to: 0.3, duration: 0))
        addChild(backgroundFade)
        backgroundFade.run(SKAction.wait(forDuration: 4)){
            self.backgroundFade.removeFromParent()
        }
    }
    
}

//MARK: - Colisão
extension GameScene: SKPhysicsContactDelegate{
    public func didBegin(_ contact: SKPhysicsContact) {
        //Teem que alterar aqui, tanto o mirror como o invisibleWall
        if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "mirror" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "mirror"{
            
            damege(node: player)
            
            if invisibleWallCount == 2 {
                changeText(msgTxt1: gameText.textValues["text4"]!, msgTxt2: gameText.textValues["text4_2"]!, color: .brown, timeWait: nil, completion: nil)
                
                addChild(self.trueVisionPower)
                
                powerRise.run(SKAction.changeVolume(to: 0.3, duration: 0))
                addChild(powerRise)
                powerRise.run(SKAction.wait(forDuration: 3)){
                    self.powerRise.removeFromParent()
                }
                
                invisibleWallCount = -1
            } else if gotPowerVision  && !beginFrases{
               finalAct()
            }
            
        } else if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "trueVisionPower" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "trueVisionPower" {
            
            if !gotPowerVision {
                
                changeScenario()
                
                changeText(msgTxt1: gameText.textValues["text5"]!, msgTxt2: gameText.textValues["text5_2"]!, color: .white, timeWait: 0, completion: nil)
                
                self.addChild(self.clonePlayer)
                clonePlayer.run(SKAction.fadeIn(withDuration: 1)){
                    self.clonePlayer.alpha = 1.0
                }
                
                gotPowerVision = true
            }
        } else if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "titaniumPower" || contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "titaniumPower" {
            
            if !gotPowerTitanium{
                titaniumPower.physicsBody = nil
                gotPowerTitanium = true
                
                titaniumPower.run(SKAction.fadeOut(withDuration: 1)){
                    self.titaniumPower.removeFromParent()
                }
                playerTransformation()
            }
        }
            print("a: \(contact.bodyA.node?.name ?? "nada"), B: \(contact.bodyB.node?.name ?? "nada")")
            
    }
}
