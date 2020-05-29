//
//  GameScene+SKPhysicsContactDelegate.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 28/03/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene : SKPhysicsContactDelegate{
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
            
        case bodyCategory.rocket.rawValue | bodyCategory.obstacle.rawValue:

            explosion.position = contact.bodyA.node!.position
            explosion.isHidden = false
            
            explosion.run(SKAction.wait(forDuration: 0.4), completion: {
                self.explosion.isHidden = true
            })
            
            setSamePhase()
            
        case bodyCategory.rocket.rawValue | bodyCategory.spaceStation.rawValue:
            
            self.rocket.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.rocket.physicsBody?.angularVelocity = 0
            self.rocket.physicsBody?.isDynamic = false
            
            self.run(SKAction.wait(forDuration: 1), completion: {
                self.setNextPhase()
                
                switch self.gameState.currentState {
                case is PhaseOne:
                    self.gameState.enter(PhaseTwo.self)
                    
                case is PhaseTwo:
                    self.gameState.enter(PhaseThree.self)
                    
                case is PhaseThree:
                    self.gameState.enter(PhaseFour.self)
                    
                case is PhaseFour:
                    self.gameState.enter(PhaseFive.self)
                    
                case is PhaseFive:
                    if let view = self.view as? GameViewController{
                        self.view?.presentScene(view.finalScene)
                    }
                default:
                    break
                }
            })
            
        case bodyCategory.rocket.rawValue | bodyCategory.celestialGravity.rawValue:
            
            let rotate = SKAction.run {
                if Float((contact.bodyB.node?.parent!.position.x)!) > Float((contact.bodyA.node?.position.x)!){
                    self.rocket.zRotation = self.rocket.zRotation - 0.04
                    
                }else{
                    self.rocket.zRotation = self.rocket.zRotation + 0.04
                }
            }
            
            self.run(SKAction.repeatForever(SKAction.sequence([rotate, SKAction.wait(forDuration: 0.1)])), withKey: "RocketRotation")
            
        default:
            break
        }
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        case bodyCategory.rocket.rawValue | bodyCategory.celestialGravity.rawValue:
            
            self.removeAction(forKey: "RocketRotation")
            
        default:
            break
        }
    }
}
