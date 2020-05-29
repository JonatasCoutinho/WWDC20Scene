//
//  PhaseFive.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 03/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import SpriteKit
import GameplayKit

public class PhaseFive: GKState {

    unowned let gameScene: GameScene
    var phaseElements: [SKNode] = []

    public override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PhaseOne.Type
    }
    
    public override func didEnter(from previousState: GKState?) {
        setScene()
    }

    public override func willExit(to nextState: GKState) {
        gameScene.removeChildren(in: phaseElements)
        phaseElements.removeAll()
    }
    
    func setScene(){
        let label = SKLabelNode(text: "Final Phase")
        label.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height * 0.6)
        label.fontName = "OCR-A"
        label.fontSize = 70
        
        let currentPlanet = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetaInicial1/PlanetaInicial1"), size: CGSize(width: gameScene.size.width / 2, height: gameScene.size.height * 0.08))
        
        currentPlanet.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height * 0.27 + (currentPlanet.size.height / 2.1))
        
        phaseElements.append(currentPlanet)
        phaseElements.append(label)
        
        gameScene.addChild(currentPlanet)
        gameScene.addChild(label)
        
        gameScene.speedSlider.isEnabled = false
        gameScene.angleSlider.isEnabled = false
        
        gameScene.launchButton.isUserInteractionEnabled = true
        gameScene.launchButton.color = .gray
        gameScene.launchButton.colorBlendFactor = 0.4
        
        label.run(SKAction.fadeAlpha(to: 0, duration: 2), completion: {
            self.createCelestialBodies()
            self.gameScene.launchButton.colorBlendFactor = 0
            
            self.gameScene.launchButton.isUserInteractionEnabled = false
            self.gameScene.speedSlider.isEnabled = true
            self.gameScene.angleSlider.isEnabled = true
        })
    }
    
    func createCelestialBodies(){
        let blackHole = CelestialBody(size: CGSize(width: gameScene.size.width * 0.3, height: gameScene.size.width * 0.3), position: CGPoint(x: gameScene.size.width * 0.2, y: gameScene.size.height * 0.6), texture: SKTexture(imageNamed: "Buraco Negro/Buraco Negro"))
        blackHole.zPosition = 2
        blackHole.gravityField.region = SKRegion(radius: Float(gameScene.size.width))
        blackHole.gravityField.strength = 7.5
        blackHole.celestialGravity.removeFromParent()
        blackHole.removeAllActions()
        blackHole.run(SKAction.repeatForever(SKAction.rotate(byAngle: 2, duration: 4)))
        
        phaseElements.append(blackHole)
        
        gameScene.addChild(blackHole)
    }

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
}
