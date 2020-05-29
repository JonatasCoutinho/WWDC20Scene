//
//  GameScene+Touches.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 01/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene{
    
   public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches{
            
            let location = touch.location(in: self)
            let nodeTouched = self.atPoint(location)
            
            if launchButton.contains(nodeTouched){

                launchButton.colorBlendFactor = 0.4
                launchButton.color = .gray
                launchButton.texture = SKTexture(imageNamed: "Botao 2/Botao 2")
                
                rocket.fire.isHidden = false
                
                let speed = Int(((speedSlider.value / 10) + 1) * 15)
                let angle = Int(Float(speed) * Float(Int(angleSlider.value)) / 10)
                
                rocket.physicsBody?.isDynamic = true
                rocket.physicsBody?.applyImpulse(CGVector(dx: angle, dy: speed))
                
                speedSlider.isEnabled = false
                angleSlider.isEnabled = false
                launchButton.isUserInteractionEnabled = true
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            let nodeTouched = self.atPoint(location)
            
            if launchButton.contains(nodeTouched){
                launchButton.texture = SKTexture(imageNamed: "Botao/Botao")
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
