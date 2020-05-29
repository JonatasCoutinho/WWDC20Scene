//
//  SceneWall.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 02/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

public class SceneWall: SKSpriteNode{
    
    
    public init(size: CGSize, position: CGPoint){
        super.init(texture: nil, color: .clear, size: size)
        self.position = position
        
        createPhysicsBody()
    }
    
    func createPhysicsBody(){
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = bodyCategory.obstacle.rawValue
        self.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
