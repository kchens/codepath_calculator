//
//  ViewController.swift
//  CodePath
//
//  Created by Kevin Chen on 8/16/15.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var billTitle: UILabel!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipTitle: UILabel!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var lineDiv: UIView!
  @IBOutlet weak var totalTitle: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  
  // Set constants
  let defaults             = NSUserDefaults.standardUserDefaults()
  let lastBillKey          = "lastBillKey"
  let tipControlDefaultKey = "tipControlDefaultKey"
  let startBlank           = "startBlank"
  let darkThemeDefaultKey  = "darkThemeDefaultKey"
  let tipPercentages = [0.10, 0.15, 0.2]
  
  var currencySymbol    = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setUpView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onEditingChanged(sender: AnyObject) {
    updateLabels()
  }
  
  @IBAction func onTap(sender: AnyObject) {
    view.endEditing(true)
  }
  
  func updateLabels() {
    let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
    
    let billAmount = NSString(string: billField.text).doubleValue
    let tip = billAmount * tipPercentage
    let total = billAmount + tip
    
    tipLabel.text = NSNumberFormatter.localizedStringFromNumber(tip as NSNumber, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
    totalLabel.text = NSNumberFormatter.localizedStringFromNumber(total as NSNumber, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
  }
  
  func setUpView() {
    animateBillField()
    animateLineDiv()
    setBillFieldBorders()
    setColorScheme()
    checkToClearBillAmount()
    updateLabels()
    localizeCurrency()
    billField.becomeFirstResponder()
  }
  
  func localizeCurrency() {
    currencySymbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as! String
    currencyLabel.text = currencySymbol
  }
  
  func checkToClearBillAmount() {
    if defaults.boolForKey(startBlank) == true {
      billField.text = ""
    } else {
      billField.text = defaults.stringForKey(lastBillKey)
    }
  }
  
  func setBillFieldBorders() {
    billField.layer.borderWidth = 1.0;
    billField.layer.cornerRadius = 5.0;
  }
  
  func setColorScheme() {
    if defaults.boolForKey(darkThemeDefaultKey) {
      // Set darkTheme as default
      view.backgroundColor      = UIColor.purpleColor()
      currencyLabel.textColor   = UIColor.whiteColor()
      billTitle.textColor       = UIColor.whiteColor()
      
      billField.backgroundColor = UIColor.purpleColor()
      billField.layer.borderColor = UIColor.yellowColor().CGColor
      billField.textColor       = UIColor.yellowColor()
      tipTitle.textColor        = UIColor.whiteColor()
      tipLabel.textColor        = UIColor.whiteColor()
      lineDiv.backgroundColor   = UIColor.whiteColor()
      totalTitle.textColor      = UIColor.whiteColor()
      totalLabel.textColor      = UIColor.whiteColor()
      tipControl.tintColor      = UIColor.yellowColor()
    } else {
      // Set non-default theme
      view.backgroundColor      = UIColor.greenColor()
      currencyLabel.textColor   = UIColor.blackColor()
      billTitle.textColor       = UIColor.blackColor()
      
      billField.backgroundColor = UIColor.greenColor()
      billField.layer.borderColor = UIColor.blueColor().CGColor
      billField.textColor       = UIColor.blueColor()
      
      tipTitle.textColor        = UIColor.blackColor()
      tipLabel.textColor        = UIColor.blackColor()
      lineDiv.backgroundColor   = UIColor.blackColor()
      totalTitle.textColor      = UIColor.blackColor()
      totalLabel.textColor      = UIColor.blackColor()
      tipControl.tintColor      = UIColor.blueColor()
    }
  }
  
  func animateBillField() {
    billField.alpha  = 1
    tipControl.alpha = 1
    UIView.animateWithDuration(2, animations: {
      self.billField.alpha = 0
      self.tipControl.alpha = 0
      },
      completion: {
        (value: Bool) in
        UIView.animateWithDuration(2, animations: {
          self.billField.alpha  = 1
          self.tipControl.alpha = 1
        })
    })
  }
  
  func animateLineDiv() {
    lineDiv.alpha = 0
    
    UIView.animateWithDuration(2, animations: {
        self.lineDiv.alpha = 1
    })
  }
  
  func saveAppState() {
    defaults.setObject(billField.text, forKey: lastBillKey)
    defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "lastTipIndex")
    defaults.synchronize()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
//    println("view will appear")
    setColorScheme()
    tipControl.selectedSegmentIndex = defaults.integerForKey(tipControlDefaultKey)
    updateLabels()
    saveAppState()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
//    println("view did appear")
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    saveAppState()
//    println("view will disappear")
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
//    println("view did disappear")
  }
}