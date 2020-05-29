//
//  GameScene.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 27/03/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    
    var viewSize = CGSize()
    
    var rocket: Rocket = Rocket()
    var spaceStation: SpaceStation = SpaceStation()
    
    var explosion: SKEmitterNode  = SKEmitterNode()
    
    var angleSlider: CustomSlider = CustomSlider()
    var speedSlider: CustomSlider = CustomSlider()
    var currentAngle = SKLabelNode()
    var currentSpeed = SKLabelNode()
    var launchButton = SKSpriteNode()
    
    var gameState: GKStateMachine!
    var states: [GKState]!
    
    public init(size: CGSize, viewSize: CGSize) {
        self.viewSize = viewSize
        super.init(size: size)
        
    }
    
    public override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        createPanel()
        createGameElements()
        createConfigurationElements()
        
        let audio = SKAudioNode(fileNamed: "Audio/Audio")
        self.addChild(audio)
        
        states = [PhaseOne(gameScene: self), PhaseTwo(gameScene: self), PhaseThree(gameScene: self), PhaseFour(gameScene: self), PhaseFive(gameScene: self)]
        
        gameState = GKStateMachine(states: self.states)
    }
    
    public override func didMove(to view: SKView) {
        gameState.enter((PhaseOne.self))
        
        speedSlider.value = 1
        angleSlider.value = 0
        
        view.addSubview(speedSlider)
        view.addSubview(angleSlider)
    }
    
    public override func willMove(from view: SKView) {
        speedSlider.removeFromSuperview()
        angleSlider.removeFromSuperview()
    }
    
    func createPanel(){
        
        //MARK: Panel
        let panel = SKSpriteNode(texture: SKTexture(imageNamed: "Painel/Painel"), size: CGSize(width: self.size.width, height: self.size.height * 0.27))
        panel.position = CGPoint(x: self.size.width / 2, y: panel.size.height / 2)
        panel.zPosition = 1
        
        self.addChild(panel)
        
        //MARK: Angle Slider
        angleSlider = CustomSlider(frame: CGRect(x: viewSize.width * 0.04, y: viewSize.height * 0.82, width: viewSize.width * 0.2, height: viewSize.width * 0.1))
        
        angleSlider.minimumValue = -9
        angleSlider.maximumValue = 9
        angleSlider.value = 0
        
        self.angleSlider.addTarget(self, action: #selector(self.angleSliderValueChange), for: UIControl.Event.valueChanged)
        
        //        let circle = SKShapeNode(circleOfRadius: 14.5)
        //        circle.fillColor = .black
        //        circle.strokeColor = .black
        //        circle.position = CGPoint(x: self.size.width * 0.05 + angleSlider.frame.width / 2 + 15, y: self.size.height * 0.12 + self.size.width * 0.12)
        //        circle.zPosition = 2
        //        circle.physicsBody?.isDynamic = false
        //
        //        self.addChild(circle)
        //MARK: Speed Slider
        
        speedSlider = CustomSlider(frame: CGRect(x: viewSize.width * 0.25, y: viewSize.height * 0.82, width: viewSize.width * 0.2, height: viewSize.width * 0.1))
        
        speedSlider.minimumValue = 1
        speedSlider.maximumValue = 5
        speedSlider.value = 1
        
        self.speedSlider.addTarget(self, action: #selector(self.speedSliderValueChange), for: UIControl.Event.valueChanged)
        
        //MARK: Angle Label
        
        let angleLabel = SKLabelNode()
        angleLabel.position = CGPoint(x: self.size.width * 0.21, y: panel.size.height / 1.5)
        angleLabel.fontName = "OCR-A"
        angleLabel.text = "Angle"
        angleLabel.zPosition = 3
        
        self.addChild(angleLabel)
        
        //MARK: Speed Value
        
        let speedLabel = SKLabelNode()
        speedLabel.position = CGPoint(x: self.size.width * 0.42, y: panel.size.height / 1.5)
        speedLabel.fontName = "OCR-A"
        speedLabel.text = "Speed"
        speedLabel.zPosition = 3
        
        self.addChild(speedLabel)
        
        //MARK: Angle Screen
        let angleScreen = SKSpriteNode(texture: SKTexture(imageNamed: "Tela/Tela"), size: CGSize(width: self.size.width * 0.12, height: self.size.width * 0.12))
        angleScreen.position = CGPoint(x: self.size.width * 0.21, y: panel.size.height / 2.5)
        angleScreen.zPosition = 2
        
        self.addChild(angleScreen)
        
        //MARK: Speed Screen
        let speedScreen = SKSpriteNode(texture: SKTexture(imageNamed: "Tela/Tela"), size: CGSize(width: self.size.width * 0.12, height: self.size.width * 0.12))
        speedScreen.position = CGPoint(x: self.size.width * 0.42, y: panel.size.height / 2.5)
        speedScreen.zPosition = 2
        
        self.addChild(speedScreen)
        
        //MARK: Angle Value
        currentAngle.position = CGPoint(x: 0, y: currentAngle.fontSize * -0.4)
        currentAngle.text = "90º"
        currentAngle.fontName = "OCR-A"
        currentAngle.fontColor = .white
        currentAngle.zPosition = 3
        
        angleScreen.addChild(currentAngle)
        
        //MARK: Speed Value=
        currentSpeed.position = CGPoint(x: 0, y: currentAngle.fontSize * -0.4)
        currentSpeed.text = "1x"
        currentSpeed.fontName = "OCR-A"
        currentSpeed.fontColor = .white
        currentSpeed.zPosition = 3
        
        speedScreen.addChild(currentSpeed)
        
        //MARK: Launch Button
        launchButton.position = CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.15)
        launchButton.size = CGSize(width: self.size.width * 0.17, height: self.size.width * 0.17)
        launchButton.texture = SKTexture(imageNamed: "Botao/Botao")
        launchButton.zPosition = 2
        
        self.addChild(launchButton)
    }
    
    func createGameElements(){
        
        //MARK: Background
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "Espaco/Espaco"), size: self.size)
        background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        background.zPosition = -1
        
        self.addChild(background)
        
        //MARK: Spacial Station
        spaceStation = SpaceStation(size: CGSize(width: self.size.width * 0.15, height: self.size.width * 0.15), position: CGPoint(x: self.size.width * 0.5, y: (self.size.height * 0.92) - (spaceStation.size.height / 2)) , texture: SKTexture(imageNamed: "Estacao Espacial/Estacao Espacial"))
        spaceStation.zPosition = 1
        
        self.addChild(spaceStation)
        
        //MARK: Rocket
        rocket = Rocket(size: CGSize(width: self.size.height * 0.03, height: self.size.height * 0.07), position: CGPoint(x: self.size.width * 0.5, y: (self.size.height * 0.35)), texture: SKTexture(imageNamed: "Foguete/Foguete"))
        rocket.zPosition = 2
        
        self.addChild(rocket)
        
        explosion = SKEmitterNode(fileNamed: "Particulas/Explosao")!
        explosion.particleScale = 0.001
        explosion.isHidden = true
                
        self.addChild(explosion)
    }
    
    func createConfigurationElements(){
        
        let rigthLine = SceneWall(size: CGSize(width: 1, height: self.size.height), position: CGPoint(x: 0, y: self.size.height / 2))
        let leftLine =
            SceneWall(size: CGSize(width: 1, height: self.size.height), position: CGPoint(x: self.size.width, y: self.size.height / 2))
        let topLine = SceneWall(size: CGSize(width: self.size.width, height: 1), position: CGPoint(x: self.size.width / 2, y: self.size.height))
        
        self.addChild(rigthLine)
        self.addChild(leftLine)
        self.addChild(topLine)
    }
    
    func setSamePhase(){
        
        let reset = SKAction.run {
            
            self.rocket.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.35)
            
            self.rocket.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.rocket.physicsBody?.angularVelocity = 0
            self.rocket.physicsBody?.isDynamic = false
            self.rocket.fire.isHidden = true
            
            self.rocket.zRotation = CGFloat((Double.pi / -4) * Double(Int(self.angleSlider.value)))
            self.rocket.zRotation = CGFloat(self.rocket.zRotation / 9)
            
            self.removeAction(forKey: "RocketRotation")
            
            self.launchButton.colorBlendFactor = 0
            
            self.speedSlider.isEnabled = true
            self.angleSlider.isEnabled = true
            self.launchButton.isUserInteractionEnabled = false
            
        }
        self.run(reset)
    }
    
    func setNextPhase(){
        let reset = SKAction.run {
            
            self.rocket.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.35)
            
            self.rocket.fire.isHidden = true
            
            self.rocket.zRotation = 0
            self.angleSlider.value = 0
            self.speedSlider.value = 1
            self.currentAngle.text = "90º"
            self.currentSpeed.text = "1x"
            
            self.removeAction(forKey: "RocketRotation")
            
        }
        self.run(reset)
    }
    
    @objc func speedSliderValueChange(){
        speedSlider.value = roundf(speedSlider.value)
        currentSpeed.text = String(Int(speedSlider.value)) + "x"
    }
    
    @objc func angleSliderValueChange(){
        angleSlider.value = roundf(angleSlider.value)
        currentAngle.text = String((Int(angleSlider.value) * 45 / 9) + 90) + "º"
        rocket.zRotation = CGFloat((Double.pi / -4) * Double(Int(angleSlider.value)))
        rocket.zRotation = CGFloat(rocket.zRotation / 9)
    }
    
    public override func update(_ currentTime: TimeInterval){
        rocket.speedValue.text = String(Int(rocket.physicsBody!.velocity.dy))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
