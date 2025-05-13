//
//  GameScene.swift
//  IOSProj17
//
//  Created by Andy Peralta on 4/30/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var starfield: SKEmitterNode!
  var player: SKSpriteNode!

  var scoreLabel: SKLabelNode!
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }

  let possibleEnemies = ["ball","hammer", "tv"]
  var isGameOver = false
  var gameTimer: Timer?


    override func didMove(to view: SKView) {
     backgroundColor = .black

     starfield = SKEmitterNode(fileNamed: "starfield")
     starfield.position = CGPoint(x: 1024, y: 384)
     starfield.advanceSimulationTime(10)
     starfield.zPosition = -1
     addChild(starfield)

//      let p1 = "player"
//      player = SKSpriteNode(imageNamed: p1)
//      player.position = CGPoint(x: 100, y: 384)
//      player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed:"player"), size: player.size)
//      print("The player texture is: \( player.texture!) ")
//      print("The  enemy size is: \(player.size)")
//      player.physicsBody?.contactTestBitMask = 1
//      assert(player.physicsBody != nil, "Player PhysicsBody is NIL")
//      addChild(player)

       createPlayer()
       scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
       scoreLabel.position = CGPoint(x: 16, y: 16)
       scoreLabel.horizontalAlignmentMode = .left
       addChild(scoreLabel)

         score = 0

        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self

        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self,
                    selector: #selector(createEnemy), userInfo: nil, repeats: true)

       //checkPhysics()
    }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else { return }
      var location = touch.location(in: self)

      if location.y < 100 {
          location.y = 100
      } else if location.y > 668 {
          location.y = 668
      }

      player.position = location
  }

  func createPlayer() {
    let p1 = "p1"
    player = SKSpriteNode(imageNamed: p1)
    player.position = CGPoint(x: 100, y: 384)
    player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
    print("The player texture is: \( player.texture!) ")
    print("The  enemy size is: \(player.size)")
    player.physicsBody?.contactTestBitMask = 1
//    assert(player.physicsBody != nil, "Player PhysicsBody is nil")
    addChild(player)
  }
    
  @objc func createEnemy() {
      guard let enemy = possibleEnemies.randomElement() else { return }

      let sprite = SKSpriteNode(imageNamed: enemy)
      sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
      addChild(sprite)

      sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
      assert(sprite.physicsBody != nil, "Sprite PhysicsBody is NIL")
     print("The  enemy texture is: \(String(describing: sprite.texture!)) ")
     print("The  enemy size is: \(String(describing: sprite.size)) ")
      sprite.physicsBody?.categoryBitMask = 1
      sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
      sprite.physicsBody?.angularVelocity = 5
      sprite.physicsBody?.linearDamping = 0
      sprite.physicsBody?.angularDamping = 0
  }

   func didBegin(_ contact: SKPhysicsContact) {
      let explosion = SKEmitterNode(fileNamed: "explosion")!
      explosion.position = player.position
      addChild(explosion)

      player.removeFromParent()
      isGameOver = true
  }

  override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
      for node in children {
        if node.position.x < -300 {
          node.removeFromParent()
        }
      }

      if !isGameOver {
          score += 1
      }
  }

  func checkPhysics() {

          // Create an array of all the nodes with physicsBodies
          var physicsNodes = [SKNode]()

          //Get all physics bodies
    enumerateChildNodes(withName: "//.") { node, _ in
              if let _ = node.physicsBody {
                  physicsNodes.append(node)
              } else {
                print("\(String(describing: node.name)) does not have a physics body so cannot collide or be involved in contacts.")
              }
          }

  //For each node, check it's category against every other node's collion and contctTest bit mask
          for node in physicsNodes {
              let category = node.physicsBody!.categoryBitMask
              // Identify the node by its category if the name is blank
              let name = node.name != nil ? node.name : "Category \(category)"
              let collisionMask = node.physicsBody!.collisionBitMask
              let contactMask = node.physicsBody!.contactTestBitMask

              // If all bits of the collisonmask set, just say it collides with everything.
              if collisionMask == UInt32.max {
                print("\(String(describing: name)) collides with everything")
              }

              for otherNode in physicsNodes {
                if (node != otherNode) && (node.physicsBody?.isDynamic == true) {
                      let otherCategory = otherNode.physicsBody!.categoryBitMask
                      // Identify the node by its category if the name is blank
                      let otherName = otherNode.name != nil ? otherNode.name : "Category \(otherCategory)"

                      // If the collisonmask and category match, they will collide
                      if ((collisionMask & otherCategory) != 0) && (collisionMask != UInt32.max) {
                        print("\(String(describing: name)) collides with \(String(describing: otherName))")
                      }
                      // If the contactMAsk and category match, they will contact
                  if (contactMask & otherCategory) != 0 {print("\(String(describing: name)) notifies when contacting \(String(describing: otherName))")}
                  }
              }
          }
      }

}

