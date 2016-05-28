//
//  GameScene.swift
//  mazeBaller
//
//  Created by admin on 5/27/16.
//  Copyright (c) 2016 NguyenBui. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
       let manager = CMMotionManager()
        var player = SKSpriteNode()
        var goal = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.contactDelegate = self
       
        if let playerTest = self.childNodeWithName("player") {
            player = playerTest as! SKSpriteNode
        }
        
        if let goalTest = self.childNodeWithName("goal") {
            goal = goalTest as! SKSpriteNode
        }
        
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1 //every 0.1 sec it will take the data
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, error) in
            self.physicsWorld.gravity = CGVectorMake(CGFloat((data?.acceleration.x)!) * 10, CGFloat((data?.acceleration.y)!) * 10)
            
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2  || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1 {
            print("Won!")
            _ = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = gameOverScene(size: (view?.bounds.size)!)
            self.view?.presentScene(scene)

        }
        
        }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
