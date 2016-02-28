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
  
  @IBAction func startButton(sender: UIButton) {
    
  }
  
  @IBOutlet weak var startButtonOutlet: UIButton!
  
  @IBAction func textFieldDidStartEdit(sender: UITextField) {
    
    if (checkTextForNumber() == true){
      print("True is good")
    }else{
      print("False is bad")
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
