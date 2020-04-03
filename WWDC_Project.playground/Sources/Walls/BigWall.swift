import Foundation
import SpriteKit

public class BigWall: SKSpriteNode {
    public init(scene: GameScene) {
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 512,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let bigWallWidth = scene.size.width * 0.10131
        let bigWallHeight = scene.size.height * 0.47508
        
        let sizeNode = CGSize(width: bigWallWidth, height: bigWallHeight)
        let texture = SKTexture(imageNamed: "BigWall_Mono")
        
        super.init(texture: texture, color: .clear, size: sizeNode)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 1150, y: scene.size.height*0.6)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
    }
    
    public init(){}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
