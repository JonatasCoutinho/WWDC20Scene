//
//  GameViewController.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 27/03/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class GameViewController: SKView {

    var initialScene: InitialScene!
    var tutorialScene: TutorialScene!
    var gameScene: GameScene!
    var finalScene: FinalScene!
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cURL = Bundle.main.url(forResource: "Fonte/OCR-A", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(cURL! as CFURL, CTFontManagerScope.process,nil)
        
        initialScene = InitialScene(size: CGSize(width: 768, height: 1024))
        tutorialScene = TutorialScene(size: CGSize(width: 768, height: 1024), viewSize: self.frame.size)
        gameScene = GameScene(size: CGSize(width: 768, height: 1024), viewSize: self.frame.size)
        finalScene = FinalScene(size: CGSize(width: 768, height: 1024))
        
        initialScene.scaleMode = .aspectFit
        tutorialScene.scaleMode = .aspectFit
        gameScene.scaleMode = .aspectFit
        finalScene.scaleMode = .aspectFit
        
        self.presentScene(initialScene)
        
        //        self.ignoresSiblingOrder = true
        //        self.showsFPS = true
        //        self.showsNodeCount = true
        //        self.showsPhysics = true
        //        self.showsFields = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
