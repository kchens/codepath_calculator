//
//  ViewController.swift
//  CodePath
//
//  Created by Kevin Chen on 8/16/15.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Set constants
    let defaults          = NSUserDefaults.standardUserDefaults()
    let lastBillKey       = "lastBillKey"
    let tipControlDefault = "tipControlDefault"
    let startBlank        = "startBlank"
    
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
        var tipPercentages = [0.10, 0.15, 0.2]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = NSNumberFormatter.localizedStringFromNumber(tip as NSNumber, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
        totalLabel.text = NSNumberFormatter.localizedStringFromNumber(total as NSNumber, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
    }
    
    func setUpView() {
        checkToClearBillAmount()
        
//        var lastTipIndex = defaults.integerForKey("lastTipIndex")
//        if lastTipIndex >= 0 && lastTipIndex <= 2 {
//            tipControl.selectedSegmentIndex = lastTipIndex
//            println("-------")
//            println(tipControl.selectedSegmentIndex)
//        }
        updateLabels()
        
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
    
    func saveAppState() {
        defaults.setObject(billField.text, forKey: lastBillKey)
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "lastTipIndex")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
        
        tipControl.selectedSegmentIndex = defaults.integerForKey(tipControlDefault)
        updateLabels()
        saveAppState()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        saveAppState()
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }
}