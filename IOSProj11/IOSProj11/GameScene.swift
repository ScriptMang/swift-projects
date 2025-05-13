import SpriteKit
class GameScene: SKScene, SKPhysicsContactDelegate {
  var extraLife = 0
  var livesLabel: SKLabelNode!
  var numbBalls = 5 {
    didSet {
      livesLabel.text = "Lives: \(numbBalls)"
    }
  }

  var scoreLabel: SKLabelNode!
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }

  var editLabel: SKLabelNode!
  var editingMode: Bool = false {
      didSet {
          if editingMode {
              editLabel.text = "Done"
          } else {
              editLabel.text = "Edit"
          }
      }
  }

  override func didMove(to view: SKView) {
      let background = SKSpriteNode(imageNamed: "background.jpg")
      background.position  = CGPoint(x: 512, y: 384)
      background.blendMode = .replace
      background.zPosition = -1
      addChild(background)

      physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
      physicsWorld.contactDelegate = self
      makeBouncer(CGPoint(x:0, y:0))
      makeBouncer(CGPoint(x:256, y:0))
      makeBouncer(CGPoint(x:512, y:0))
      makeBouncer(CGPoint(x:768, y:0))
      makeBouncer(CGPoint(x:1024, y:0))


      makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
      makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
      makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
      makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

      scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
      scoreLabel.text = "Score: 0"
      scoreLabel.horizontalAlignmentMode = .right
      scoreLabel.position = CGPoint(x: 980, y: 700)
      addChild(scoreLabel)

      livesLabel = SKLabelNode(fontNamed: "Chalkduster")
      livesLabel.text = "Lives: 5"
      livesLabel.horizontalAlignmentMode = .right
      livesLabel.position = CGPoint(x: 580, y: 700)
      addChild(livesLabel)

      editLabel = SKLabelNode(fontNamed: "Chalkduster")
      editLabel.text = "Edit"
      editLabel.position = CGPoint(x: 80, y: 700)
      addChild(editLabel)
    }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {return}
    let location = touch.location(in: self)
    let objects = nodes(at: location)

    if objects.contains(editLabel) {
        editingMode.toggle()
    } else {
      if editingMode {
        if numbBalls > 0 {
          makeBall(location)
          numbBalls -= 1
        }
      } else {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let box =
        SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1),
          size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location

        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false

        addChild(box)
      }
    }
  }

  func makeBall(_ position: CGPoint) {
    let ballColors = ["ballRed", "ballGreen", "ballGrey",
                    "ballCyan", "ballPurple", "ballYellow", "ballBlue"]
    let ball = SKSpriteNode(imageNamed: ballColors.randomElement() ?? "ballRed")
    ball.name = "ball"
    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
    ball.physicsBody?.restitution = 0.4
    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
    ball.position = position
    addChild(ball)
  }

  func makeBouncer(_ position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
       bouncer.position = position
       bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
       bouncer.physicsBody?.isDynamic = false
       addChild(bouncer)
  }

  func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode

    if isGood == true {
      slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
      slotBase.name = "Good"
    } else {
       slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
       slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
       slotBase.name = "Bad"
    }

    slotBase.position = position
    slotGlow.position = position

    slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
    slotBase.physicsBody?.isDynamic = false

    addChild(slotBase)
    addChild(slotGlow)

    let spin = SKAction.rotate(byAngle: .pi, duration: 10)
    let spinForever = SKAction.repeatForever(spin)
    slotGlow.run(spinForever)
  }

  func collision(between ball: SKNode, object: SKNode) {
    if object.name == "Good" {
      destroy(ball: ball)
      score += 1
      extraLife += 1
      numbBalls += extraLife
    } else if object.name == "Bad"{
     destroy(ball: ball)
     score -= 1
    }
  }

  func destroy(ball: SKNode) {
     if let fireParticles = SKEmitterNode(fileNamed: "magicParticle") {
          fireParticles.position = ball.position
          addChild(fireParticles)
      }

      ball.removeFromParent()
  }

  func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA.name == "ball" {
       collision(between: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
       collision(between: nodeB, object: nodeA)
    }
  }
}
