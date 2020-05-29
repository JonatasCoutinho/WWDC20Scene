//
//  TutorialScene.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 04/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import SpriteKit

public class TutorialScene: SKScene{
    
    var viewSize = CGSize()
    var text = UILabel()
    
    public init(size: CGSize, viewSize: CGSize) {
        self.viewSize = viewSize
        super.init(size: size)
    }
    
    public override func sceneDidLoad() {
        
        let audio = SKAudioNode(fileNamed: "Audio/Audio")
        self.addChild(audio)
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "Espaco/Espaco"), size: CGSize(width: self.size.width, height: self.size.height))
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        background.color = .black
        background.colorBlendFactor = 0.7
        
        let astronaut = SKSpriteNode(texture: SKTexture(imageNamed: "Astronauta/Astronauta"), size: CGSize(width: self.size.width * 0.2, height: self.size.width * 0.2))
        astronaut.position = CGPoint(x: (self.size.width * 0.15) + (astronaut.size.width / 2), y: self.size.height * 0.8)
        astronaut.xScale = astronaut.xScale * -1
        astronaut.zPosition = 2
        
        let chatBalloon = SKShapeNode()
        chatBalloon.path = UIBezierPath(roundedRect: CGRect(x: self.size.width * 0.1, y: self.size.height * 0.1, width: self.size.width * 0.8, height: self.size.height * 0.8), cornerRadius: 100).cgPath
        chatBalloon.fillColor = .white
        chatBalloon.zPosition = 1
        
        text = UILabel(frame: CGRect(x: self.viewSize.width * 0.15, y: self.viewSize.height * 0.32, width: self.viewSize.width * 0.7, height: self.viewSize.height * 0.5))
        text.numberOfLines = 0
        text.font = UIFont(name: "OCR-A", size: 50)
        text.adjustsFontSizeToFitWidth = true
        text.text = "Hey, what’s up? I need some help here. We have to go to all the space stations to fix them, but first you have to set the rocket angle and speed for me. Be careful when setting these values, take into account that the rocket will interact with some gravitational fields of the planets until it gets there."
        text.textAlignment = .justified
        
        let label = SKLabelNode(text: "Tap to continue")
        label.position = CGPoint(x: self.size.width / 2 , y: self.size.height * 0.05)
        label.fontSize = 30
        label.fontName = "OCR-A"
        
        label.run(SKAction.repeatForever( SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 1.5), SKAction.fadeAlpha(to: 1, duration: 1.5)])))
        label.zPosition = 2
        
        self.addChild(label)
        self.addChild(background)
        self.addChild(astronaut)
        self.addChild(chatBalloon)
    }
    
    public override func didMove(to view: SKView) {
        view.addSubview(text)
    }
    
    public override func willMove(from view: SKView) {
        text.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
