//
//  Games.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 3/2/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import SpriteKit

class Games: SKScene, SKPhysicsContactDelegate {
  
  let numberCardTrue = SKSpriteNode(imageNamed: "box")
  let numberCardFalse = SKSpriteNode(imageNamed: "box")
  let canister = SKSpriteNode(imageNamed: "bucket")
  var objectToPrimeify:Primes = Primes()
  var bucketTop:SKSpriteNode = SKSpriteNode()
  var bucketBottom:SKSpriteNode = SKSpriteNode()
  var sieve:SKSpriteNode = SKSpriteNode()
  var tempArray = [Bool]()
  var nodeRetainCount:Int = 0
  var labelBox = SKLabelNode()
  var xLabel:Int=Int()
  var rotateWarning = SKSpriteNode()
  
  struct physicsIdentification {
    static let noneItem:UInt32 = 0
    static let allItem:UInt32 = UInt32.max
    static let numberCardTrueItem:UInt32 = 0b1
    static let numberCardFalseItem:UInt32 = 0b10
    static let sieveItem:UInt32 = 0b11
    static let bucketBottomItem:UInt32 = 0b100
  }
  
  override func didMoveToView(view: SKView) {
    self.tempArray = self.objectToPrimeify.primeCollection
    
    
    self.objectToPrimeify.primeCollection = self.objectToPrimeify.runPrimeSweep(self.objectToPrimeify.primeCollection, currentSmallestActualNumber: self.objectToPrimeify.currentSmallestPrime)
    //mark current prime as false so that we drop a card that will get filtered out
    self.objectToPrimeify.primeCollection[self.objectToPrimeify.currentSmallestPrime-self.objectToPrimeify.adjustIndexForFirstPrime]=false
    
    
    backgroundColor = SKColor.whiteColor()
    physicsWorld.gravity = CGVectorMake(0, 0)

    self.bucketTop = addSpawnBucket(CGPoint.init(x: size.width*0.5, y: size.height*0.9))
    self.bucketBottom = addBucket(CGPoint.init(x: size.width*0.5, y: size.height*0.1))
    self.sieve = addSieve(CGPoint.init(x: size.width*0.5, y: size.height*0.5))
    self.labelBox = addSpawnLabelBox("\(objectToPrimeify.lastSmallestPrime)")
    addChild(bucketTop)
    addChild(bucketBottom)
    addChild(sieve)
    addChild(labelBox)
    labelBox.hidden = true
    physicsWorld.contactDelegate = self
    self.rotateWarning = addRotateWarning(CGPoint.init(x: size.width*0.5, y: size.height*0.5))
    addChild(rotateWarning)
    rotateWarning.zPosition = 200
    rotateWarning.alpha = 0.5
    addNotification()
  }
  
  //Here is the "start" after setup in didMoveToView.
  func deviceRotating(){
    self.rotateWarning.hidden = true
    let rotate90degree:SKAction = SKAction.rotateToAngle(CGFloat(M_PI/2.0) , duration: 0.2)
    self.bucketTop.runAction(rotate90degree)
    nodeRetainCount = 0
    
    var x = 0
    xLabel = x
    repeat {
      if (self.objectToPrimeify.primeCollection[x]==true){
//        if((x+self.objectToPrimeify.adjustIndexForFirstPrime) == self.objectToPrimeify.currentSmallestPrime){
//        runAction(SKAction.runBlock(addNumberCardFalse))
//      nodeRetainCount++
//    }else if
//          ((x+self.objectToPrimeify.adjustIndexForFirstPrime) > self.objectToPrimeify.currentSmallestPrime){
          runAction(SKAction.runBlock(addNumberCardTrue))
          nodeRetainCount++

//        }
    
      } else if
        (objectToPrimeify.primeCollection[x]==false){
          if (tempArray[x]==true){
            runAction(SKAction.runBlock(addNumberCardFalse))
            nodeRetainCount++
            
          }
      }
      
      x++
      xLabel = x
    } while x < objectToPrimeify.primeCollection.count
    removeNotification()
  }
  
  
  func removeNotification(){
    NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
  }
  
  func addNotification(){
    UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceRotating", name: UIDeviceOrientationDidChangeNotification, object: nil)
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  func random(min min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func addNumberCardTrue() {
    let numberCardTrue = SKSpriteNode(imageNamed: "box")
    numberCardTrue.size = CGSizeMake (10.0, 10.0)
    numberCardTrue.position = CGPoint(x:size.width * 0.5 , y: size.height * 0.9)
    addChild(numberCardTrue)
    let speed = random(min: 5, max: 10)
    let falling = SKAction.moveByX(random(min: -35, max: 35), y: size.height * -1, duration: NSTimeInterval(speed))
    numberCardTrue.physicsBody = SKPhysicsBody(rectangleOfSize: numberCardTrue.size)
    numberCardTrue.physicsBody?.dynamic = true
    numberCardTrue.physicsBody?.categoryBitMask = physicsIdentification.numberCardTrueItem
    numberCardTrue.physicsBody?.contactTestBitMask = physicsIdentification.bucketBottomItem
    numberCardTrue.physicsBody?.collisionBitMask = physicsIdentification.noneItem
    numberCardTrue.runAction(falling)
  }
  
  func addNumberCardFalse() {
    let numberCardFalse = SKSpriteNode(imageNamed: "box")
    numberCardFalse.size = CGSizeMake (20.0, 20.0)
    numberCardFalse.position = CGPoint(x:size.width * 0.5 , y: size.height * 0.9)
    addChild(numberCardFalse)
    let speed = random(min: 5, max: 10)
    let falling = SKAction.moveByX(random(min: -50, max: 50), y: size.height * -1, duration: NSTimeInterval(speed))
    numberCardFalse.physicsBody = SKPhysicsBody(rectangleOfSize: numberCardFalse.size)
    numberCardFalse.physicsBody?.dynamic = true
    numberCardFalse.physicsBody?.categoryBitMask = physicsIdentification.numberCardFalseItem
    numberCardFalse.physicsBody?.contactTestBitMask = physicsIdentification.sieveItem
    numberCardFalse.physicsBody?.collisionBitMask = physicsIdentification.noneItem
    numberCardFalse.runAction(falling)
  }
  
  func addBucket(position:CGPoint)->SKSpriteNode{
    let bucket = SKSpriteNode(imageNamed: "bucket")
    bucket.size = CGSizeMake(100.0, 100.0)
    bucket.position = CGPoint(x: position.x, y: position.y)
    bucket.physicsBody = SKPhysicsBody(rectangleOfSize: bucket.size)
    bucket.physicsBody?.dynamic = true
    bucket.physicsBody?.categoryBitMask = physicsIdentification.bucketBottomItem
    bucket.physicsBody?.contactTestBitMask = physicsIdentification.numberCardTrueItem
    bucket.physicsBody?.collisionBitMask = physicsIdentification.noneItem
    
    return bucket
  }
  
  func addSpawnBucket(position:CGPoint)->SKSpriteNode{
    let bucket = SKSpriteNode(imageNamed: "bucket")
    bucket.size = CGSizeMake(100.0, 100.0)
    bucket.position = CGPoint(x: position.x, y: position.y)
    return bucket
  }
  
  func addSpawnLabelBox(textToDisplay:String)->SKLabelNode{
    let labelBox = SKLabelNode(text:"\(textToDisplay): is a Prime!")
    labelBox.fontName = "Courier"
    labelBox.position.x = ((size.width * 0.85) - (labelBox.frame.size.width)/10)
    labelBox.position.y = (size.height * 0.80)
    labelBox.fontColor = UIColor.blackColor()
    labelBox.fontSize = 20.0
    
    return labelBox
  }
  
  func addRotateWarning(position:CGPoint)->SKSpriteNode{
    let rotateWarning = SKSpriteNode(imageNamed: "rotate")
    rotateWarning.size = CGSizeMake(size.width * 0.5, size.height * 0.5)
    rotateWarning.position = CGPoint(x: position.x, y: position.y)
    return rotateWarning
  }
  
  
  
  func addSieve(position:CGPoint)->SKSpriteNode{
    let sieve = SKSpriteNode(imageNamed: "sieve")
    sieve.size = CGSizeMake(200, 100)
    sieve.position  = CGPoint(x: position.x, y: position.y)
    sieve.physicsBody = SKPhysicsBody(rectangleOfSize: sieve.size)
    sieve.physicsBody?.categoryBitMask = physicsIdentification.sieveItem
    sieve.physicsBody?.contactTestBitMask = physicsIdentification.numberCardFalseItem
    sieve.physicsBody?.collisionBitMask = physicsIdentification.noneItem
    
    return sieve
  }
  
  
  func numberCardRemoveCard(numberCard:SKSpriteNode){
    numberCard.removeFromParent()
    nodeRetainCount--
    if nodeRetainCount == 0 {
      resetTheWorld()
    }
    
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    
    var firstBody: SKPhysicsBody = contact.bodyB
    var secondBody: SKPhysicsBody = contact.bodyA
    
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    }
    //    print("firstBody.categoryBitMask:\(firstBody.categoryBitMask)")
    //    print("secondBody.categoryBitMask:\(secondBody.categoryBitMask)")
    
    if (firstBody.categoryBitMask==1 && secondBody.categoryBitMask==4){
      numberCardRemoveCard(firstBody.node as! SKSpriteNode)
    }
    
    if (firstBody.categoryBitMask==2 && secondBody.categoryBitMask==3){
      numberCardRemoveCard(firstBody.node as! SKSpriteNode)
    }
    
    
  }
  
  func resetTheWorld(){
    let rotateBackToZeroDegree:SKAction = SKAction.rotateToAngle(CGFloat(0 * M_PI) , duration: 0.2)
    
    let bucketTopPosition = bucketTop.position
    let bucketBottomZPosition = bucketBottom.zPosition
    let bucketBottomPosition = bucketBottom.position
    
    
    let moveToTop:SKAction = SKAction.moveToY(size.height * 0.5, duration: 1)
    let moveBackToBottom:SKAction = SKAction.moveToY(bucketBottomPosition.y, duration: 1)
    
    let moveToBottom:SKAction = SKAction.moveToY(size.height * 0.5, duration: 1)
    let moveBackToTop:SKAction = SKAction.moveToY(bucketTopPosition.y, duration: 1)
    
    let moveAway:SKAction = SKAction.moveToX(size.width*2.0, duration: 1)
    let moveBack:SKAction = SKAction.moveToX(size.width*0.5, duration: 1)
    
    self.bucketTop.runAction(rotateBackToZeroDegree)
    
    self.bucketTop.runAction(moveToBottom, completion: { () -> Void in
      self.bucketTop.runAction(moveBackToTop)
    })
    
    self.bucketBottom.runAction(moveToTop, completion:{() -> Void in
      self.bucketBottom.zPosition = -100
      self.bucketBottom.runAction(moveBackToBottom, completion: { () -> Void in
        self.bucketBottom.zPosition = bucketBottomZPosition
      })
    })
    
    
    self.sieve.runAction(moveAway) { () -> Void in
      self.sieve.runAction(moveBack, completion: { () -> Void in
        self.addNotification()
        self.objectToPrimeify.getNewSmallestPrime()
        self.tempArray = self.objectToPrimeify.primeCollection
        self.objectToPrimeify.primeCollection = self.objectToPrimeify.runPrimeSweep(self.objectToPrimeify.primeCollection, currentSmallestActualNumber: self.objectToPrimeify.currentSmallestPrime)
        //mark current prime as false so that we drop a card that will get filtered out
        self.objectToPrimeify.primeCollection[self.objectToPrimeify.currentSmallestPrime-self.objectToPrimeify.adjustIndexForFirstPrime]=false
        self.rotateWarning.hidden = false
        self.labelBox.text = ("\(self.objectToPrimeify.lastSmallestPrime) is a Prime!")
        self.labelBox.hidden = false

      })
    }
  }
  
}
