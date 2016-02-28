//
//  MainViewController.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/26/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  
  
  //Achtung need a regex here to prevent pasting
  @IBAction func startButton(sender: UIButton) {
    
    let userValue = NSInteger(Int(textField.text!)!)
    var userCollection = [Bool]()
    for(var x=0;x < userValue; x++){
      let temp = true
      userCollection.append(temp)
    }
    let numbers = Primes.init(userUpperLimit: userValue, userCollection: userCollection)
    print(numbers.primeCollection.count)
  }
  
  @IBOutlet weak var startButtonOutlet: UIButton!
  
  @IBAction func textFieldDidStartEdit(sender: UITextField) {
    
    if (checkTextForNumber() == true){
      print("True is good")
      self.startButtonOutlet.enabled = true
    }else{
      print("False is bad")
      self.startButtonOutlet.enabled = false
    }
    
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.startButtonOutlet.enabled = false
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func checkTextForNumber()->Bool{
    var isValid:Bool=false

    if let text = self.textField.text where !text.isEmpty
    {
      if (Int(text) > 1){
        isValid = true
        return isValid
      }
      
      isValid = false
      return isValid
    }
    return isValid
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
