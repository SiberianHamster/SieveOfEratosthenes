//
//  Primes.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/26/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class Primes: NSObject {

  var primeCollection = [Bool]()
  var primeUpperLimit = NSInteger()
  var currentSmallestPrime:NSInteger = 2
  let adjustIndexForFirstPrime:NSInteger = 2
  
  init(userUpperLimit:NSInteger, userCollection:[Bool]){
    self.primeUpperLimit = userUpperLimit
    self.primeCollection = userCollection
  }
  
  func runPrimeSweep(){
      print("Sweep")
  }
  
  func getNewSmallestPrime()->NSInteger{

    if (currentSmallestPrime < primeUpperLimit){
      
      while (primeCollection[currentSmallestPrime + adjustIndexForFirstPrime].boolValue == false){
        currentSmallestPrime++
        print("Current Smallest Prime\(currentSmallestPrime)")
      }
      
  }else{
      print("you are at the end")
      print("Current Smallest Prime\(currentSmallestPrime)")

  }
  return currentSmallestPrime
}

}