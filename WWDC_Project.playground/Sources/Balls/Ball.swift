import Foundation
import SpriteKit

public class Ball: SKSpriteNode {
    public init(scene: GameScene) {
        /// Tamanho da Tela (iPad): Largura = 1366 Altura = 1024
        /// Tamanho do Player Lrgura = 117 Altura = 123
        /// Calculo Referente a Tela: Largura = 0.10689 Altura = 0.12695
        
        let playerWidth = scene.size.width * 0.095651
        let playerHeight = scene.size.height * 0.13011
        let sizeNode = CGSize(width: playerWidth, height: playerHeight)
        
        let texture = SKTexture(imageNamed: "PlayerBall.png")
        
        super.init(texture: texture, color: .clear, size: sizeNode)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.position = CGPoint(x: scene.size.width * 0.15, y: scene.size.height * 0.5)
        
        /// Cria o corpo que receberá a aplicação da física - esse é o jeito mais performático
        self.physicsBody = SKPhysicsBody(circleOfRadius: (playerWidth/2)-3)
    }
    
    public init(){}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
