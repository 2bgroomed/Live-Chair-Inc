//
//  PriceViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 6/9/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//


import UIKit

class PriceViewController: UIViewController {
    
    @IBOutlet var cutTxt: UITextField!
    @IBOutlet var priceTxt: UITextField!
    @IBOutlet var discountedPriceTxt: UITextField!
    
    @IBAction func saveBtn(sender: UIButton) {
        
        let cut = self.cutTxt.text! as String
        let price = self.priceTxt.text! as String
        let discountedPrice = self.discountedPriceTxt.text! as String
        
        let url = NSURL(string: "http://www.livechairapp.com.php56-33.ord1-1.websitetestlink.com/price")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = "cut=\(cut)&price=\(price)&discounted_price=\(discountedPrice)".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
                
                if (json["error"] != nil) {
                    dispatch_async(dispatch_get_main_queue(), {
                        print("\(json["error"])")
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        print("\(json["success"])")
                         //self.navigationController?.performSegueWithIdentifier("priceSegue", sender: nil)
                        self.dismissViewControllerAnimated(true, completion: nil)
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
    

}
