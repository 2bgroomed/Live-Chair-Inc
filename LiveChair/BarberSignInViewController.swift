//
//  BarberSignInViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 3/19/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import Foundation
import UIKit

class BarberSignInViewController: UIViewController {
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var errorLbl: UILabel!
    @IBAction func enterBtn(sender: UIButton) {
        
        let email = self.emailTxt.text! as String
        let password = self.passwordTxt.text! as String
        
        let url = NSURL(string: "http://localhost/livechairapp/signin")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = "email=\(email)&password=\(password)".dataUsingEncoding(NSUTF8StringEncoding)
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
                        
                        print(json)
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setValue(email, forKey: "email")
                        defaults.setValue(password, forKey: "password")
                        defaults.setValue(json["shop"], forKey: "shopName")
                        defaults.setValue(json["address"], forKey: "shopAddress")
                        
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