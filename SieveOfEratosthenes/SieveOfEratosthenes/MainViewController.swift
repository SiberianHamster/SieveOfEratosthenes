//
//  MainViewController.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/26/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
 
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var textField: UITextField!
  
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
      self.titleLabel.textColor = constants.kThemeComplimentaryColor
      self.descriptionLabel.textColor = constants.kThemeComplimentaryColor
      self.view.backgroundColor = constants.kBackground
      self.textField.backgroundColor = constants.kThemeMainColor
      self.textField.textColor = constants.kThemeComplimentary2Color
      self.startButtonOutlet.setTitleColor(constants.kThemeDisabledColor, forState: UIControlState.Disabled)
      self.startButtonOutlet.setTitleColor(constants.kThemeComplimentary2Color, forState: UIControlState.Normal)
      
        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.textField.text = nil
    self.startButtonOutlet.enabled = false
    checkTextForNumber()
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
        if(Int(text)>constants.someLargeNumberToWarnUser){
        self.startButtonOutlet.setTitle("Redonkulous! There will be wait times", forState: UIControlState.Normal)
        }
      }else{
      self.startButtonOutlet.setTitle("Please enter a number larger than 1", forState: UIControlState.Normal)
      isValid = false
    }
      
    }else {
      self.startButtonOutlet.setTitle("Enter a Number", forState: UIControlState.Normal)
    }
    return isValid
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "showTabBar"){
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc1 = storyboard.instantiateViewControllerWithIdentifier("ResultVC") as! ResultViewController
      vc1.tabBarItem.title = "Standard/Businesslike"
      let vc2 = storyboard.instantiateViewControllerWithIdentifier("CreativeVC") as! CreativeViewController
      vc2.tabBarItem.title = "More Creative"

      
      let userMax = NSInteger(Int(self.textField.text!)!)
      vc1.usersMax = userMax
      
      let arrayofVC = [vc1,vc2]
      
      let destination = segue.destinationViewController as! UITabBarController
      destination.viewControllers = arrayofVC
      destination.tabBar.barTintColor = UIColor.blackColor()
      destination.tabBar.tintColor = UIColor.lightGrayColor()


    }
  }

}
