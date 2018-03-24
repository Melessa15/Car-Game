//
//  GameScene.swift
//  Car Game
//
//  Created by Profes Particulares on 23/03/2018.
//  Copyright © 2018 Herts university. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var road: SKSpriteNode = SKSpriteNode(imageNamed: "road1")
    private var road2: SKSpriteNode = SKSpriteNode(imageNamed: "road1")
    
    private var playersCar = SKSpriteNode(imageNamed: "car0")
    let height = CGFloat(1334)
    let width = CGFloat(750)
    let roadSpeed = 5.0
    
    override func didMove(to view: SKView) {
        
        self.setup1stRoad()
        self.setup2ndRoad()
        
        playersCar.size = CGSize(width: playersCar.size.width / 4,
                                 height: playersCar.size.height / 4)
        self.addChild(playersCar)
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    func setup1stRoad() {
        self.addChild(road)
        self.road.size = CGSize(width: self.width, height: self.height)
        let action1 = SKAction.moveBy(x: 0, y: -self.height, duration: self.roadSpeed)
        let action2 = SKAction.moveBy(x: 0, y: 2*self.height, duration: 0)
        let action3 = SKAction.moveBy(x: 0, y: -self.height, duration: self.roadSpeed)
        let sequence = SKAction.sequence([action1, action2, action3])
        let repetition = SKAction.repeatForever(sequence)
        self.road.run(repetition)
    }
    
    func setup2ndRoad() {
        self.addChild(road2)
        
        self.road2.size = CGSize(width: self.width, height: self.height)
        let action1 = SKAction.moveBy(x: 0, y: self.height, duration: 0)
        let action2 = SKAction.moveBy(x: 0, y: -2*self.height, duration: self.roadSpeed * 2)
        let action3 = SKAction.moveBy(x: 0, y: self.height, duration: 0)
        let sequence = SKAction.sequence([action1, action2, action3])
        let repetition = SKAction.repeatForever(sequence)
        self.road2.run(repetition)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
