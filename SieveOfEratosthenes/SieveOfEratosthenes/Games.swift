//
//  Games.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 3/2/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import SpriteKit

class Games: SKScene, UIAccelerometerDelegate {
  
  let numberCard = SKSpriteNode(imageNamed: "box")
  let canister = SKSpriteNode(imageNamed: "can")
  let sieve = SKSpriteNode(imageNamed: "sieve")
  var objectToPrimeify:Primes = Primes()
  
  override func didMoveToView(view: SKView) {
    backgroundColor = SKColor.whiteColor()
    
    UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceRotating", name: UIDeviceOrientationDidChangeNotification, object: nil)

    
  }
  
  func deviceRotating(){
        print(" notification \(UIDeviceOrientationDidChangeNotification)")
    var x = 0
    repeat {
      if (objectToPrimeify.primeCollection[x]==true){
        runAction(SKAction.runBlock(addNumberCard))}
      x++
    } while x < objectToPrimeify.primeCollection.count
    NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  func random(min min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func addNumberCard() {
    
    let numberCard = SKSpriteNode(imageNamed: "box")
    numberCard.size = CGSizeMake (10.0, 10.0)
    numberCard.position = CGPoint(x:size.width * 0.5 , y: size.height * 0.9)
    addChild(numberCard)
    let speed = random(min: 0.5, max: 2)
    let falling = SKAction.moveByX(random(min: -50, max: 50), y: size.height * -1, duration: NSTimeInterval(speed))
    numberCard.runAction(falling)
  }

}
