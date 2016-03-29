//
//  ClientSignUpViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 3/23/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import Foundation
import UIKit

class ClientSignUpViewController: UIViewController {
    
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var errorLbl: UILabel!
    @IBAction func doneBtn(sender: UIButton) {
        
        let email = self.emailTxt.text! as String
        let password = self.passwordTxt.text! as String
        let name = self.nameTxt.text! as String
        
        let url = NSURL(string: "http://localhost/livechairapp/signup/client")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = "email=\(email)&password=\(password)&name=\(name)".dataUsingEncoding(NSUTF8StringEncoding)
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
                        defaults.setValue(name, forKey: "name")
                        
                        self.navigationController?.performSegueWithIdentifier("clientHomeSegue", sender: nil)
                    })
                }
                
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            }
            
            
        })
        
        task.resume()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.backItem?.title = ""
    }
}