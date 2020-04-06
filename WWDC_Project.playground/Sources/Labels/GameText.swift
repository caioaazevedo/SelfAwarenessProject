import Foundation
import SpriteKit

public class GameText {
    
    public var textLabel = SKLabelNode(fontNamed: "Geneva")
    public var textLabelLine2 = SKLabelNode(fontNamed: "Geneva")
    
    var textValues = ["text1": "Sometimes in life you have obstacles",
                      "text1_2": "that you need to overcome",
                      "text2": "Some are harder than others",
                      "text2_2": "",
                      "text3": "But sometimes...",
                      "text3_2": "",
                      "text4": "You just can't get through them",
                      "text4_2": "But why?",
                      "text5": "TRUE VISION",
                      "text5_2": "Allows you to see what you couldn't",
                      "text6": "This is what really happens",
                      "text6_2": "",
                      "text7": "The most difficult obstacle to cross",
                      "text7_2": "is yourself",
                      "text8": "While you block your own progress",
                      "text8_2": "you also get hurt because of it",
                      "text9": "You are both the victim and the aggressor",
                      "text9_2": "",
                      "text10": "Now that you know you are",
                      "text10_2": "your own enemy",
                      "text11": "What if you were able to change that?",
                      "text11_2": "",
                      "text12": "How to fight an enemy that is yourself?",
                      "text12_2": "",
                      "text13": "SELF AWARENESS",
                      "text13_2": "Allows you to understand who you really are",
                      "text14": "And with that you shield yourself",
                      "text14_2": "Now that enemy doesn't affect you anymore",
                      "text15": "So... How much do you know yourself?"]
    
    public init(scene: GameScene) {
        ///Configuração e adição do texto na Tela
        
        self.textLabel.text = self.textValues["text1"]
        self.textLabel.fontSize = 20
        self.textLabel.fontColor = SKColor.brown
        self.textLabel.position = CGPoint(x: scene.frame.size.width*0.35, y: scene.size.height*0.9)
        
        self.textLabelLine2.text = self.textValues["text1_2"]
        self.textLabelLine2.fontSize = 20
        self.textLabelLine2.fontColor = SKColor.brown
        self.textLabelLine2.position = CGPoint(x: scene.frame.size.width*0.35, y: scene.size.height*0.85)
    }
    
    public init(){}
    
}
