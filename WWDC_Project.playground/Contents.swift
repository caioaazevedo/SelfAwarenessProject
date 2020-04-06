import PlaygroundSupport
import SpriteKit

let skView = SKView(frame: CGRect(x:0 , y:0, width: 683, height: 512))
//let scene = GameScene(size: CGSize(width: 683, height: 512))
let initial = InitialScene(size: CGSize(width: 683, height: 512))

    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    
    // Present the scene
    skView.presentScene(initial)

PlaygroundPage.current.liveView = skView
