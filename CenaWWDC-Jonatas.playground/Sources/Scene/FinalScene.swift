import Foundation
import SpriteKit

public class FinalScene: SKScene{
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    public override func sceneDidLoad() {
        
        let audio = SKAudioNode(fileNamed: "Audio/Final")
        audio.run(SKAction.changeVolume(to: 0.05, duration: 0))
        self.addChild(audio)
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "Espaco/Espaco"), size: CGSize(width: self.size.width, height: self.size.height))
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.color = .black
        background.colorBlendFactor = 0.7
        
        self.addChild(background)
        
        let label = SKLabelNode(text: "Congratulations\n  You did it!")
        label.numberOfLines = 0
        label.position = CGPoint(x: self.size.width / 2 , y: self.size.height / 2)
        label.fontSize = 70
        label.fontName = "OCR-A"
        self.addChild(label)
        
        label.run(SKAction.repeatForever( SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 1.5), SKAction.fadeAlpha(to: 1, duration: 1.5)])))
        
        let planet = SKSpriteNode()
        planet.size = CGSize(width: self.size.width * 0.2, height: self.size.width * 0.2)
        
        let positions = [CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.8), CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.3), CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85), CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.2), CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.8), CGPoint(x: self.size.width * 0.6, y: self.size.height * 0.35), CGPoint(x: self.size.width * 0.45, y: self.size.height * 0.85), CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.25)]
        
        let textures = [SKTexture(imageNamed: "Planeta 1/Planeta 1"), SKTexture(imageNamed: "Planeta 2/Planeta 2"), SKTexture(imageNamed: "Planeta 3/Planeta 3"), SKTexture(imageNamed: "Planeta 4/Planeta 4"), SKTexture(imageNamed: "Planeta 5/Planeta 5"), SKTexture(imageNamed: "Planeta 6/Planeta 6"), SKTexture(imageNamed: "Planeta 7/Planeta 7"), SKTexture(imageNamed: "Planeta 8/Planeta 8")]
        
        planet.run(SKAction.repeatForever(SKAction.sequence([SKAction.rotate(byAngle: 1, duration: 1), SKAction.rotate(byAngle: -1, duration: 1)])))
        
        planet.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(to: positions[0], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[1], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[2], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[3], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[4], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[5], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[6], duration: 0), SKAction.wait(forDuration: 1), SKAction.move(to: positions[7], duration: 0), SKAction.wait(forDuration: 1)])))
        
        planet.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 1)))
        
        self.addChild(planet)
    }
    
    public override func didMove(to view: SKView) {
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
