import Foundation
import SpriteKit

public class Power {
    public var trueVisionPower = SKShapeNode()
    
    init(scene: GameScene, bigWall: BigWall) {
        self.trueVisionPower = SKShapeNode(circleOfRadius: 25)
        self.trueVisionPower.position = CGPoint(x: bigWall.position.x + scene.size.width*0.6, y: scene.size.height*0.4)
        self.trueVisionPower.fillColor = .blue
        self.trueVisionPower.name = "trueVisionPower"
        self.trueVisionPower.physicsBody = SKPhysicsBody(circleOfRadius: trueVisionPower.frame.size.width/2)
        self.trueVisionPower.physicsBody?.isDynamic = false
    }
    
    public init(){}
}
