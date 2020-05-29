//
//  BaseEspacial.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 27/03/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

public class SpaceStation: SKSpriteNode{
    
    public init(){
        super.init(texture: nil, color: .clear, size: .zero)
    }
    
    public init(size: CGSize, position: CGPoint, texture: SKTexture){
        super.init(texture: texture, color: .clear, size: size)
        
        self.position = position
        
//        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.categoryBitMask = bodyCategory.spaceStation.rawValue
        
        self.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
