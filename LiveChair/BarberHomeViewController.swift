//
//  BarberHomeViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 3/19/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import Foundation
import UIKit

class BarberHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let shopName = defaults.stringForKey("shopName") {
            self.navigationItem.title = shopName
        }
    }
}