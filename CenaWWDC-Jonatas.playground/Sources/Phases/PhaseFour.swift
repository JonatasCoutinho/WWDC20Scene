//
//  PhaseFour.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 03/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import SpriteKit
import GameplayKit

public class PhaseFour: GKState {

    unowned let gameScene: GameScene
    var phaseElements: [SKNode] = []

    public override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PhaseFive.Type
    }
    
    public override func didEnter(from previousState: GKState?) {
        setScene()
    }

    public override func willExit(to nextState: GKState) {
        gameScene.removeChildren(in: phaseElements)
        phaseElements.removeAll()
    }
    
    func setScene(){
        let label = SKLabelNode(text: "Phase 4")
        label.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height * 0.6)
        label.fontName = "OCR-A"
        label.fontSize = 70
        
        let currentPlanet = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetaInicial2/PlanetaInicial2"), size: CGSize(width: gameScene.size.width / 2, height: gameScene.size.height * 0.08))
        
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
       
        let planet1 = CelestialBody(size: CGSize(width: gameScene.size.width * 0.1, height: gameScene.size.width * 0.1), position: CGPoint(x: gameScene.size.width * 0.3, y: gameScene.size.height * 0.76), texture: SKTexture(imageNamed: "Planeta 1/Planeta 1"))
        
        let ringPlanet1 = SKSpriteNode(texture: SKTexture(imageNamed: "Planeta 1 anel/Planeta 1 anel"), size: CGSize(width: planet1.size.width * 1.6, height: planet1.size.height * 0.4))
        
        ringPlanet1.position = CGPoint(x: planet1.position.x + planet1.size.width * 0.03, y: planet1.position.y)
        ringPlanet1.zPosition = 2
        ringPlanet1.zRotation = 0.3
        
        let planet2 = CelestialBody(size: CGSize(width: gameScene.size.width * 0.1, height: gameScene.size.width * 0.1), position: CGPoint(x: gameScene.size.width * 0.5, y: gameScene.size.height * 0.6), texture: SKTexture(imageNamed: "Planeta 7/Planeta 7"))
        
        let planet3 = CelestialBody(size: CGSize(width: gameScene.size.width * 0.1, height: gameScene.size.width * 0.1), position: CGPoint(x: gameScene.size.width * 0.7, y: gameScene.size.height * 0.44), texture: SKTexture(imageNamed: "Planeta 3/Planeta 3"))
        
        let planet4 = CelestialBody(size: CGSize(width: gameScene.size.width * 0.1, height: gameScene.size.width * 0.1), position: CGPoint(x: gameScene.size.width * 0.7, y: gameScene.size.height * 0.76), texture: SKTexture(imageNamed: "Planeta 8/Planeta 8"))
        
        let planet5 = CelestialBody(size: CGSize(width: gameScene.size.width * 0.1, height: gameScene.size.width * 0.1), position: CGPoint(x: gameScene.size.width * 0.3, y: gameScene.size.height * 0.44), texture: SKTexture(imageNamed: "Planeta 4/Planeta 4"))
        
        phaseElements.append(planet1)
        phaseElements.append(ringPlanet1)
        phaseElements.append(planet2)
        phaseElements.append(planet3)
        phaseElements.append(planet4)
        phaseElements.append(planet5)
        
        gameScene.addChild(planet1)
        gameScene.addChild(ringPlanet1)
        gameScene.addChild(planet2)
        gameScene.addChild(planet3)
        gameScene.addChild(planet4)
        gameScene.addChild(planet5)
    }

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
}
