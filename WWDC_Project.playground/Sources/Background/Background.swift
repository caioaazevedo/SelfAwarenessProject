import Foundation
import SpriteKit

class Background: SKSpriteNode {
    public init(scene: GameScene, positionX: CGFloat) {
        let sizeNode = CGSize(width: 1187, height: scene.frame.size.height)
        let texture = SKTexture(imageNamed: "Background_Mono.png")
        super.init(texture: texture, color: UIColor.clear, size: sizeNode)
        /// Anchor Point Zero - significa que o ponto de ancoragem do sprite é o canto Inferior Esquerdo dele
        self.anchorPoint = CGPoint.zero
        
        /// A posição do background varia no eixo X, pois o backgroud é instanciado várias vezes para montar o espaço do cenário
        self.position = CGPoint(x: positionX, y: 0)
        self.zPosition = -1
    }
    
    public init(){}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
