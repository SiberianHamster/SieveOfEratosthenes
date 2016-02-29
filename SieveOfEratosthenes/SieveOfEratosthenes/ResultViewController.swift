//
//  ResultViewController.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/28/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var usersMax:NSInteger=NSInteger()
  var objectToPrimeify:Primes=Primes()

  @IBAction func detectPrimeButton(sender: UIButton) {
    let aNumber = self.objectToPrimeify.primeCollection.count + self.objectToPrimeify.adjustIndexForFirstPrime
    if(NSInteger(Int(sqrt(Double(aNumber)))) < usersMax){
    let returnValue = self.objectToPrimeify.runPrimeSweep(self.objectToPrimeify.primeCollection, currentSmallest: self.objectToPrimeify.currentSmallestPrime)
    self.objectToPrimeify.primeCollection = returnValue
    }
    
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
    }
  
  override func viewDidAppear(animated: Bool) {
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.objectToPrimeify.primeCollection.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ResultTableViewCell
    let currentCellNumber = self.objectToPrimeify.primeCollection[indexPath.row]
    let currentNumber = indexPath.row + self.objectToPrimeify.adjustIndexForFirstPrime
    cell.numberLabel.text = String(currentNumber)
    if(currentCellNumber.boolValue == false){
      cell.statusLabel.text = "Not Prime"
    }else if(currentNumber < self.objectToPrimeify.currentSmallestPrime){
      cell.statusLabel.text = "Prime"
    }else{
      cell.statusLabel.text = "Not Evaluated"
    }
    return cell
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
