//
//  BarberSignUpViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 3/19/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import Foundation
import UIKit

class BarberSignUpViewController: UIViewController {
    
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var shopNameTxt: UITextField!
    @IBOutlet var shopAddressTxt: UITextField!
    @IBOutlet var errorLbl: UILabel!
    
    @IBAction func doneBtn(sender: UIButton) {
        
        let email = self.emailTxt.text! as String
        let password = self.passwordTxt.text! as String
        let shopName = self.shopNameTxt.text! as String
        let shopAddress = self.shopAddressTxt.text! as String
        
        let url = NSURL(string: "http://www.livechairapp.com.php56-33.ord1-1.websitetestlink.com/signup/barber")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = "email=\(email)&password=\(password)&shop=\(shopName)&address=\(shopAddress)&type=barber".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
                
            if (json["error"] != nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.errorLbl.text = json["error"] as? String
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(email, forKey: "email")
                    defaults.setValue(password, forKey: "password")
                    defaults.setValue(shopName, forKey: "shopName")
                    defaults.setValue(shopAddress, forKey: "shopAddress")
                    
                    self.navigationController?.performSegueWithIdentifier("barberHomeSegue", sender: nil)
                })
            }
            
        } catch {
            print(error)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
            
            
        })
        
        task.resume()
        

    }
    
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
        
        // Nav Bar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.backItem?.title = ""
    }
}