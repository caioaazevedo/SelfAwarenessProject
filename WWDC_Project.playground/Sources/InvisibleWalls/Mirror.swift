import Foundation
import SpriteKit

public class Mirror {
    var mirror = SKShapeNode()
    public init(scene: GameScene, smallWall: SmallWall) {
        let positionX = smallWall.position.x
        
         self.mirror = SKShapeNode(rect: CGRect(x: positionX, y: 0, width: 0, height: scene.size.height))
         self.mirror.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
         self.mirror.physicsBody?.isDynamic = false
         self.mirror.physicsBody?.restitution = 0.8
         self.mirror.alpha = 1.0
         self.mirror.name = "mirror"
         self.mirror.fillColor = .blue
         self.mirror.physicsBody?.collisionBitMask = 0b0001
    }
    
    public init(){}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
