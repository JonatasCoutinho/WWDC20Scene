//
//  Foguete.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 27/03/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

public class Rocket: SKSpriteNode{
    
    var speedValue: SKLabelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
    var gravityValue: SKLabelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
    var fire: SKEmitterNode = SKEmitterNode()
    var explosion: SKEmitterNode = SKEmitterNode()
    
    public init(){
        super.init(texture: nil, color: .clear, size: .zero)
    }
    
    public init(size: CGSize, position: CGPoint, texture: SKTexture){
        super.init(texture: texture, color: .clear, size: size)
        
        self.position = position
        
//        initiateRocketNodes()
        
//        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.contactTestBitMask = bodyCategory.obstacle.rawValue | bodyCategory.spaceStation.rawValue | bodyCategory.celestialGravity.rawValue
        self.physicsBody?.fieldBitMask = bodyCategory.gravityField.rawValue
        self.physicsBody?.categoryBitMask = bodyCategory.rocket.rawValue
        self.physicsBody?.collisionBitMask = bodyCategory.obstacle.rawValue | bodyCategory.spaceStation.rawValue
        
        self.physicsBody?.restitution = 0
        
        fire = SKEmitterNode(fileNamed: "Particulas/Fogo")!
        fire.position = CGPoint(x: 0, y: self.size.height / -2)
        fire.particleScale = 0.02
        
        fire.isHidden = true
        
        self.addChild(fire)
    }
    
    func initiateRocketNodes(){
        let gravityIcon = SKSpriteNode(texture: SKTexture(imageNamed: "Gravidade/Gravidade"), size: CGSize(width: size.width * 0.4, height: size.width * 0.4))
        gravityIcon.position = CGPoint(x: self.size.width * 0.9, y: self.size.height * -0.15)
        
        let speedIcon = SKSpriteNode(texture: SKTexture(imageNamed: "Velocidade/Velocidade"), size: CGSize(width: size.width * 0.4, height: size.width * 0.4))
        speedIcon.position = CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.15)
        
        speedValue.text = "100"
        speedValue.fontSize = size.width * 0.4
        speedValue.position = CGPoint(x: speedIcon.position.x * 0.8, y: (speedValue.fontSize / -2))
        
        gravityValue.text = "9.4"
        gravityValue.fontSize = size.width * 0.4
        gravityValue.position = CGPoint(x: speedIcon.position.x * 0.8, y: (gravityValue.fontSize / -2))
        
        self.addChild(gravityIcon)
        self.addChild(speedIcon)
        speedIcon.addChild(speedValue)
        gravityIcon.addChild(gravityValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
