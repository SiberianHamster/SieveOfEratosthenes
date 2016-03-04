//
//  CreativeViewController.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 3/2/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit
import SpriteKit

class CreativeViewController: UIViewController {
  
  var usersMax:NSInteger = NSInteger()
  var objectToPrimeify:Primes = Primes()
  var gameView:Games=Games()


    override func viewDidLoad() {
        super.viewDidLoad()
      
      resetArray()
      gameView = Games(size: view.bounds.size)
      gameView.objectToPrimeify = self.objectToPrimeify
      let skView = view as! SKView
      gameView.scaleMode = .ResizeFill
      skView.presentScene(gameView)

        // Do any additional setup after loading the view.
    }
  

  func resetArray(){
      var x = 0
      repeat{
        self.objectToPrimeify.primeCollection[x]=true
        x++}
        while x < self.objectToPrimeify.primeCollection.count
  }
  
  override func viewWillAppear(animated: Bool) {
    gameView.addNotification()
  }
  
  override func viewWillDisappear(animated: Bool) {
    gameView.removeNotification()
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
