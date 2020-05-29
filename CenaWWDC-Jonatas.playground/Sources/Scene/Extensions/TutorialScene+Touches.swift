//
//  TutorialScene+Touches.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 05/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

extension TutorialScene{
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let view = self.view as? GameViewController{
            self.view?.presentScene(view.gameScene)
        }
    }
}
