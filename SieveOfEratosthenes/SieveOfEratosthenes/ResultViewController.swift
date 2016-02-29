//
//  ResultViewController.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/28/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var usersMax:NSInteger = NSInteger()
  var objectToPrimeify:Primes = Primes()

  @IBOutlet weak var detectPrimeOutlet: UIButton!
  
  @IBAction func detectPrimeButton(sender: UIButton) {

//    //cut loop in half by not running the sweep on numbers greater than square root of maximum. if it is 2 then we move to next number
////    if(self.objectToPrimeify.currentSmallestPrime < NSInteger(NSInteger(sqrt(Double(self.objectToPrimeify.primeUpperLimit + 1))))){
//    let returnValue = self.objectToPrimeify.runPrimeSweep(self.objectToPrimeify.primeCollection, currentSmallest: self.objectToPrimeify.currentSmallestPrime)
//    self.objectToPrimeify.primeCollection = returnValue
////    }
//    
//    
//    self.objectToPrimeify.getNewSmallestPrime()
    self.objectToPrimeify.primeCollection = self.objectToPrimeify.runPrimeSweep(self.objectToPrimeify.primeCollection, currentSmallestActualNumber: self.objectToPrimeify.currentSmallestPrime)
    
    self.objectToPrimeify.getNewSmallestPrime()
    
    self.detectPrimeOutlet.setTitle("Sweep for \(self.objectToPrimeify.currentSmallestPrime)", forState: UIControlState.Normal)
    
    self.tableView.reloadData()

  }
  
  @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

      var userCollection = [Bool]()
      for(var x = self.objectToPrimeify.adjustIndexForFirstPrime; x <= usersMax; x++){
        let temp = true
        userCollection.append(temp)
      }

        self.objectToPrimeify = Primes.init(userUpperLimit: usersMax, userCollection: userCollection)
      self.tableView.delegate = self
      self.tableView.dataSource = self
        // Do any additional setup after loading the view.
          self.detectPrimeOutlet.setTitle("Sweep for \(self.objectToPrimeify.currentSmallestPrime)", forState: UIControlState.Normal)
    }



  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.objectToPrimeify.primeCollection.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ResultTableViewCell
    let currentCellNumber = self.objectToPrimeify.primeCollection[indexPath.row]
    let actualNumber = self.objectToPrimeify.getAcutalNumberForIndexRow(indexPath.row)
    cell.numberLabel.text = String(actualNumber)
    if(currentCellNumber.boolValue == false){
      cell.statusLabel.text = "Not Prime"
    }else
  if(actualNumber <= self.objectToPrimeify.lastSmallestPrime){
      cell.statusLabel.text = "Prime"
    }else
  {
      cell.statusLabel.text = "Not Evaluated"
    }
    return cell
  }
  
  

}
