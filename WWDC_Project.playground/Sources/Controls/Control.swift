import Foundation
import SpriteKit

public class Control {
    
    public var btnBackwards = SKSpriteNode(imageNamed: "Assets/ButtonBackward.png")
    public var btnFowards = SKSpriteNode(imageNamed: "Assets/ButtonForward.png")
    public var btnJump = SKSpriteNode(imageNamed: "Assets/ButtonJump.png")
    
    init(scene: GameScene) {
        
        let size = scene.size.width*0.08
        
        ///Adição do botão de movimento para  trás
        self.btnBackwards.size = CGSize(width: size, height: size)
        self.btnBackwards.position = CGPoint(x: scene.camera!.position.x+scene.size.width*0.7, y: scene.size.height*0.1)
        ///Da um nome ao botao, como uma espécie de identificador
        self.btnBackwards.name = "backwards"
        
        scene.addChild(btnBackwards)
        
        ///Adição do botão de movimento para  frente
        self.btnFowards.size = CGSize(width: size, height: size)
        self.btnFowards.position = CGPoint(x: scene.camera!.position.x+scene.size.width*0.8, y: scene.size.height*0.1)
        ///Da um nome ao botao, como uma espécie de identificador
        self.btnFowards.name = "fowards"
        
        scene.addChild(btnFowards)
        
        ///Adição do botão de movimento para  frente
        self.btnJump.size = CGSize(width: size, height: size)
        self.btnJump.position = CGPoint(x: scene.camera!.position.x+scene.size.width*0.9, y: scene.size.height*0.1)
        ///Da um nome ao botao, como uma espécie de identificador
        self.btnJump.name = "jump"
        
        scene.addChild(btnJump)
    }
    
    public init(){}
}
