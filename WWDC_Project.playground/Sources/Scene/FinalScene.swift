import Foundation
import SpriteKit

public class FinalScene: SKScene {
    var backgrooundScene = SKSpriteNode(imageNamed: "Assets/FinalBackground.png")
    var title = SKLabelNode(fontNamed: "Geneva")
    var titleLine2 = SKLabelNode(fontNamed: "Geneva")
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        backgrooundScene.size = self.size
        backgrooundScene.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        backgrooundScene.zPosition = 0
        addChild(backgrooundScene)
        
        title.text = "So..."
        title.fontSize = 40
        title.color = .white
        title.alpha = 0.0
        title.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.75)
        self.addChild(self.title)
        
        self.titleLine2.text = "How much do you know yourself?"
        self.titleLine2.fontSize = 40
        self.titleLine2.alpha = 0.0
        self.titleLine2.color = .white
        self.titleLine2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.6)
        self.addChild(self.titleLine2)
        
        title.run(SKAction.fadeIn(withDuration: 1)){
            self.title.alpha = 1.0
            self.titleLine2.run(SKAction.fadeIn(withDuration: 1)){
                self.titleLine2.alpha = 1.0
            }
        }
        
        
        
    }
}
