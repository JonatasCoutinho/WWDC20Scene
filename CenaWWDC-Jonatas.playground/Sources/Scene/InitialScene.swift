//
//  InitialScene.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 04/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

public class InitialScene: SKScene{
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    public override func sceneDidLoad() {
        
        let audio = SKAudioNode(fileNamed: "Audio/Audio")
        self.addChild(audio)
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "Espaco/Espaco"), size: CGSize(width: self.size.width, height: self.size.height))
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.color = .black
        background.colorBlendFactor = 0.7
        
        self.addChild(background)
        
        let planet = SKSpriteNode(texture: SKTexture(imageNamed: "Planeta 1/Planeta 1"), size: CGSize(width: self.size.width * 0.7, height: self.size.width * 0.7))
        planet.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.6)
        
        planet.run(SKAction.repeatForever(SKAction.rotate(byAngle: 1, duration: 1)))
        planet.run(SKAction.repeatForever( SKAction.animate(with: [SKTexture(imageNamed: "Planeta 2/Planeta 2"), SKTexture(imageNamed: "Planeta 3/Planeta 3"), SKTexture(imageNamed: "Planeta 4/Planeta 4"), SKTexture(imageNamed: "Planeta 5/Planeta 5"), SKTexture(imageNamed: "Planeta 6/Planeta 6"), SKTexture(imageNamed: "Planeta 7/Planeta 7"), SKTexture(imageNamed: "Planeta 8/Planeta 8"), SKTexture(imageNamed: "Planeta 1/Planeta 1"), ], timePerFrame: 2.5)))
        
        self.addChild(planet)
        
        let rocket = SKSpriteNode(texture: SKTexture(imageNamed: "Foguete/Foguete"), size: CGSize(width: planet.size.width * 0.1, height: planet.size.width * 0.2))
        rocket.position = CGPoint(x: (planet.size.height / 2) + (rocket.size.width / 1.5), y: 0)
        
        planet.addChild(rocket)
        
        let fire = SKEmitterNode(fileNamed: "Particulas/Fogo")!
        fire.position = CGPoint(x: 0, y: rocket.size.height / -2)
        fire.particleScale = 0.04
        
        rocket.addChild(fire)
        
        let label = SKLabelNode(text: "Tap to play")
        label.position = CGPoint(x: self.size.width / 2 , y: self.size.height * 0.1)
        label.fontSize = 50
        label.fontName = "OCR-A"
        self.addChild(label)
        
        label.run(SKAction.repeatForever( SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 1.5), SKAction.fadeAlpha(to: 1, duration: 1.5)])))
    }
    
    public override func didMove(to view: SKView) {
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
