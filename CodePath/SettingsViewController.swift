//
//  SettingsViewController.swift
//  CodePath
//
//  Created by Kevin Chen on 8/17/15.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Set constants
    let defaults          = NSUserDefaults.standardUserDefaults()
    let tipControlDefault = "tipControlDefault"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var defaults = NSUserDefaults.standardUserDefaults()
        var intValue = defaults.integerForKey(tipControlDefault)
        tipControl.selectedSegmentIndex = intValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnTappedDismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onEditingDefaultChanged(sender: AnyObject) {
        var chosenTipIndex = tipControl.selectedSegmentIndex
        defaults.setInteger(chosenTipIndex, forKey: tipControlDefault)
        defaults.synchronize()
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
