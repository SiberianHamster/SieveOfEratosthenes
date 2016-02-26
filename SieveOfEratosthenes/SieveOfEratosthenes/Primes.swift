//
//  Primes.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/26/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class Primes: NSObject {

  let primeCollection = [Bool]()
  var primeUpperLimit = NSInteger()
  
  init(userUpperLimit:NSInteger) {

    self.primeUpperLimit = userUpperLimit
    
  }
  
}
