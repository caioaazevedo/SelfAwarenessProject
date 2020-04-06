import Foundation
import SpriteKit

public class Power : SKSpriteNode{
    init(scene: GameScene, bigWall: BigWall) {
        /// Tamanho da Tela (iPad): Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 117 Altura = 123
        /// Calculo Referente a Tela: Largura = 0.102489 Altura = 0.140635
        
        let playerWidth = scene.size.width * 0.152489
        let playerHeight = scene.size.height * 0.200635
        let sizeNode = CGSize(width: playerWidth, height: playerHeight)
        let texture = SKTexture(imageNamed: "Assets/TrueVisionPower.png")
        super.init(texture: texture, color: .clear, size: sizeNode)
        
        self.position = CGPoint(x: bigWall.position.x + scene.size.width*0.5, y: scene.size.height*0.45)
        self.name = "trueVisionPower"
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody!.contactTestBitMask = 0b0001
    }
    
    public init(){
        super.init(texture: nil, color: .clear, size: CGSize.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
