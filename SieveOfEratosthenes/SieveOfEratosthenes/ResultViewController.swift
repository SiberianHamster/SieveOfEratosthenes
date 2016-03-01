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

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBOutlet weak var resetOutlet: UIButton!
  
  @IBOutlet weak var detectPrimeOutlet: UIButton!
  
  @IBOutlet weak var fastOutlet: UIButton!
  
  @IBAction func fastButton(sender: UIButton) {
    self.detectPrimeOutlet.enabled = false
    self.fastOutlet.enabled = false
    self.activityIndicator.hidden = false
    
    
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      repeat {
        self.sweep()}
        while self.objectToPrimeify.currentSmallestPrime != self.objectToPrimeify.lastSmallestPrime
      
      dispatch_async(dispatch_get_main_queue()) {
        self.activityIndicator.hidden = true
        self.detectPrimeOutlet.enabled = true
        self.fastOutlet.enabled = true
        self.tableView.reloadData()
      }
    }
    


    


    
  }
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBAction func resetButton(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func detectPrimeButton(sender: UIButton) {

    sweep()
    
    self.tableView.reloadData()

  }
  
  @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

      self.activityIndicator.hidden = true
      tableView.backgroundColor = UIColor.clearColor()
      self.fastOutlet.setTitleColor(constants.kThemeDisabledColor, forState: UIControlState.Disabled)
      self.detectPrimeOutlet.setTitleColor(constants.kThemeDisabledColor, forState: UIControlState.Disabled)
      self.fastOutlet.setTitleColor(constants.kThemeComplimentary2Color, forState: UIControlState.Normal)
      self.view.backgroundColor = constants.kBackground
      self.titleLabel.textColor = constants.kThemeComplimentaryColor
    self.detectPrimeOutlet.setTitleColor(constants.kThemeComplimentary2Color, forState: UIControlState.Normal)
    self.resetOutlet.setTitleColor(constants.kThemeComplimentary2Color, forState: UIControlState.Normal)
    
      
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
    cell.layer.cornerRadius = constants.kRoundedBox
    if(currentCellNumber.boolValue == false){
      cell.statusLabel.text = "Not Prime"
      
      cell.layer.backgroundColor = UIColor.darkGrayColor().CGColor
    }else
  if(actualNumber <= self.objectToPrimeify.lastSmallestPrime){
      cell.statusLabel.text = "Prime"
    cell.layer.backgroundColor = constants.kThemeMainColor.CGColor

    }else
  {
      cell.statusLabel.text = "Not Evaluated"
      cell.layer.backgroundColor = constants.kThemeDisabledColor.CGColor
    
    }
    return cell
  }
  
  func sweep(){
    
    self.objectToPrimeify.primeCollection = self.objectToPrimeify.runPrimeSweep(self.objectToPrimeify.primeCollection, currentSmallestActualNumber: self.objectToPrimeify.currentSmallestPrime)
    
    self.objectToPrimeify.getNewSmallestPrime()
    
    self.detectPrimeOutlet.setTitle("Sweep for \(self.objectToPrimeify.currentSmallestPrime)", forState: UIControlState.Normal)
    
  }
  

}
