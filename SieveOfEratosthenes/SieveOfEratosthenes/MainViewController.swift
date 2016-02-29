//
//  MainViewController.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/26/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  let someLargeNumberToWarnUser = 100000
  
  @IBOutlet weak var textField: UITextField!
  
  //Achtung need a regex here to prevent pasting
  @IBAction func startButton(sender: UIButton) {

  }
  
  @IBOutlet weak var startButtonOutlet: UIButton!
  
  @IBAction func textFieldDidStartEdit(sender: UITextField) {
    
    if (checkTextForNumber() == true){
      self.startButtonOutlet.enabled = true
    }else{
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
        self.startButtonOutlet.setTitle("Lets Do It!", forState: UIControlState.Normal)
        isValid = true
        if(Int(text)>someLargeNumberToWarnUser){
        self.startButtonOutlet.setTitle("You might have to wait a while!", forState: UIControlState.Normal)
        }
      }else{
      self.startButtonOutlet.setTitle("Please enter a number larger than 1", forState: UIControlState.Normal)
      isValid = false
    }
  }
    return isValid
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "showResultsSegue"){
      
     let destinationVC = segue.destinationViewController as! ResultViewController
      let userMax = NSInteger(Int(self.textField.text!)!)
//      print("Object Count: \(textField.text)")
      destinationVC.usersMax = userMax

    }
  }

}
