import Foundation
import SpriteKit

public class SmallWall: SKSpriteNode {
    public init(scene: GameScene) {
        /// Tamanho da Tela: Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 134,45 Altura = 112,61
        /// Calculo Referente a Tela: Largura = 0.10131 Altura = 0.50008
        
        let smallWallWidth = scene.size.width * 0.098096
        let smallWallHeight = scene.size.height * 0.109970
        
        let sizeNode = CGSize(width: smallWallWidth, height: smallWallHeight)
        let texture = SKTexture(imageNamed: "Assets/SmallWall_Mono")
        
        super.init(texture: texture, color: .clear, size: sizeNode)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 2000, y: scene.size.height*0.4)
        
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
