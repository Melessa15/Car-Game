//
//  GameOverScene.swift
//  Car Game
//
//  Created by 16084105 on 24/03/2018.
//  Copyright © 2018 Herts university. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var score: Int!
    let button = SKSpriteNode(imageNamed: "play_again")
    override func didMove(to view: SKView) {
        let scoreDisplay = SKLabelNode(text: "Your score was: \(self.score!)")
        scoreDisplay.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 200)
        self.addChild(scoreDisplay)
        
        let gameOverNode = SKSpriteNode(imageNamed: "game_over")
        let ratio = self.size.width / gameOverNode.size.width
        
        self.backgroundColor = UIColor.black
        
        gameOverNode.size = CGSize(width: self.size.width, height: self.size.height / ratio)
        gameOverNode.position = CGPoint(x: gameOverNode.size.width / 2, y: self.size.height - gameOverNode.size.height / 2)
        self.addChild(gameOverNode)
        
        self.addChild(button)
        button.position = CGPoint(x: self.size.width / 2, y: scoreDisplay.position.y - 200)
        button.name = "button"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "button"
            {
                if let scene = SKScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view?.presentScene(scene)
                }
                
            }
        }
    }
}
