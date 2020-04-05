import Foundation
import SpriteKit

public class MediumWall: SKSpriteNode {
    public init(scene: GameScene) {
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 138,39 Altura = 512,09
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let mediumWallWidth = scene.size.width * 0.101024
        let mediumWallHeight = scene.size.height * 0.212890
        
        let sizeNode = CGSize(width: mediumWallWidth, height: mediumWallHeight)
        let texture = SKTexture(imageNamed: "Assets/MediumWall_Mono")
        
        super.init(texture: texture, color: .clear, size: sizeNode)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: scene.size.width * 0.55, y: scene.size.height*0.45)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
    }
    
    public init(){
        super.init(texture: nil, color: .clear, size: CGSize.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
