import Foundation
import SpriteKit

public class Ground {
    public var ground = SKShapeNode()
    
    public init(scene: GameScene) {
        
        let cgRect = CGRect(x: 0, y: scene.size.height*0.35, width: 2500, height: 5)
        self.ground = SKShapeNode(rect: cgRect)
        
        self.ground.physicsBody = SKPhysicsBody(edgeLoopFrom: self.ground.frame)
        self.ground.physicsBody?.restitution = 0.5
        self.ground.physicsBody?.isDynamic = false
        self.ground.alpha = 0
        self.ground.name = "Ground"
        
        
    }
    
    public init(){}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
