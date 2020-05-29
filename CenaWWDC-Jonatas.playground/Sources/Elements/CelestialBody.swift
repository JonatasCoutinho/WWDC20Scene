//
//  CorpoCeleste.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 27/03/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

public class CelestialBody: SKSpriteNode{

    var celestialGravity = SKShapeNode()
    var gravityField = SKFieldNode()
    
    public init(){
        super.init(texture: nil, color: .clear, size: .zero)
    }
    
    public init(size: CGSize, position: CGPoint, texture: SKTexture){
        super.init(texture: texture, color: .clear, size: size)
        
        self.position = position
        
//        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.categoryBitMask = bodyCategory.obstacle.rawValue
        self.physicsBody?.isDynamic = false
        
        celestialGravity = SKShapeNode(circleOfRadius: size.width * 1.4)
        celestialGravity.fillColor = .white
        celestialGravity.alpha = 0.25
        celestialGravity.physicsBody = SKPhysicsBody(circleOfRadius: size.width * 1.4)
        celestialGravity.physicsBody?.categoryBitMask = bodyCategory.celestialGravity.rawValue
        celestialGravity.physicsBody?.isDynamic = false
        
        self.addChild(celestialGravity)
        
        gravityField = SKFieldNode.radialGravityField()
        gravityField.region = SKRegion(radius: Float(size.width * 1.6))
        gravityField.strength = 0.4
        gravityField.categoryBitMask = bodyCategory.gravityField.rawValue
        
        self.addChild(gravityField)
        
        let rotationDirection = [1, -1]
        let randomInt = Int.random(in: 0...1)
        
        self.run( SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(rotationDirection[randomInt]), duration: 4)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
