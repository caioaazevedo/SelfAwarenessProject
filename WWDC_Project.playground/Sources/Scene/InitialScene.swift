import Foundation
import SpriteKit

public class InitialScene: SKScene {
    var backgrooundScene = SKSpriteNode(imageNamed: "Assets/InitialBackground.png")
    var title = SKLabelNode(fontNamed: "Geneva")
    var titleLine2 = SKLabelNode(fontNamed: "Geneva")
    var titleLine3 = SKLabelNode(fontNamed: "Geneva")
    var starButton = SKSpriteNode(imageNamed: "Assets/StartButton.png")

    public override init(size: CGSize) {
        super.init(size: size)
        
        addChild(backgrooundScene)
        addChild(title)
        addChild(titleLine2)
        addChild(titleLine3)
        addChild(starButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func didMove(to view: SKView) {
        backgrooundScene.size = self.size
        backgrooundScene.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        backgrooundScene.zPosition = -1
        
        
        title.text = "This is a Game"
        title.fontSize = 30
        title.fontColor = .brown
        title.zPosition = 10
        title.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.83)
        

        titleLine2.text = "About"
        titleLine2.fontSize = 30
        titleLine2.fontColor = .brown
        titleLine2.zPosition = 10
        titleLine2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        

        titleLine3.text = "You"
        titleLine3.fontSize = 50
        titleLine3.fontColor = .brown
        titleLine2.zPosition = 10
        titleLine3.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.55)
        
        
        starButton.size = CGSize(width: self.size.width*0.278184, height: self.size.height*0.087890)
        starButton.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        starButton.zPosition = 10
        starButton.alpha = 0.0
        starButton.name = "start"
        
       
        starButton.run(SKAction.fadeIn(withDuration: 1)){
            self.starButton.alpha = 1.0
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            ///Verificação do node tocado com o nome identificador do botão
            if node.name == "start" {
                let scene = GameScene(size: self.size)
                self.run(SKAction.fadeOut(withDuration: 1)){
                    self.view?.presentScene(scene)
                }
            }
        }
    }
}
