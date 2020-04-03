import Foundation
import SpriteKit

public class Control {
    
    public var btnBackwards = SKShapeNode()
    public var btnFowards = SKShapeNode()
    public var btnJump = SKShapeNode()
    
    init(scene: GameScene) {
        self.btnBackwards = SKShapeNode(circleOfRadius: 25)
        
        ///Adição do botão de movimento para  trás
        self.btnBackwards.fillColor = .blue
        self.btnBackwards.position = CGPoint(x: scene.camera!.position.x+scene.size.width*0.1, y: scene.size.height*0.1)
        ///Da um nome ao botao, como uma espécie de identificador
        self.btnBackwards.name = "backwards"
        
        scene.addChild(btnBackwards)
        
        self.btnFowards = SKShapeNode(circleOfRadius: 25)
        ///Adição do botão de movimento para  frente
        self.btnFowards.fillColor = .red
        self.btnFowards.position = CGPoint(x: scene.camera!.position.x+scene.size.width*0.2, y: scene.size.height*0.1)
        ///Da um nome ao botao, como uma espécie de identificador
        self.btnFowards.name = "fowards"
        
        scene.addChild(btnFowards)
        
        self.btnJump = SKShapeNode(circleOfRadius: 25)
        ///Adição do botão de movimento para  frente
        self.btnJump.fillColor = .green
        self.btnJump.position = CGPoint(x: scene.camera!.position.x+scene.size.width*0.3, y: scene.size.height*0.1)
        ///Da um nome ao botao, como uma espécie de identificador
        self.btnJump.name = "jump"
        
        scene.addChild(btnJump)
    }
    
    public init(){}
}
