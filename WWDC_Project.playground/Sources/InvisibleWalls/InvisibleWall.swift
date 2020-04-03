import Foundation
import SpriteKit

public class InvisibleWall{
    public var invisibleWall = SKShapeNode()
    public init(scene: GameScene) {
         let posX = scene.size.width
         self.invisibleWall = SKShapeNode(rect: CGRect(x: posX, y: 0, width: 0, height: scene.size.height))
         self.invisibleWall.alpha = 1.0
         self.invisibleWall.name = "invisibleWall"
         self.invisibleWall.fillColor = .blue
    }
    
    public init(){}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
