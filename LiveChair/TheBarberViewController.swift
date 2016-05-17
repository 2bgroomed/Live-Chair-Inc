//
//  TheBarberViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 4/20/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import UIKit
import MapKit

class TheBarberViewController: UIViewController, UIActionSheetDelegate {

    @IBOutlet var bgImg: UIImageView!
    @IBOutlet var barberLbl: UILabel!
    @IBOutlet var bookView: UIView!
    @IBOutlet var mapView: UIView!
    
    
    @IBAction func backBtn(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareBtn(sender: UIButton) {
        let activityViewController = UIActivityViewController( activityItems: ["LiveChair is great!"], applicationActivities: nil)
        
        activityViewController.setValue("Hey, check it out!", forKey: "subject")
        
        self.presentViewController(activityViewController, animated: true, completion: {
        })
    }
    
    
    @IBAction func bookBtn(sender: UIButton) {
        bookView.hidden = false
    }
    
    @IBAction func cancelBtn(sender: UIButton) {
        bookView.hidden = true
    }
    
    @IBAction func bookThisTimeBtn(sender: UIButton) {
        bookView.hidden = true
    }
    
    @IBAction func mapBtn(sender: UIButton) {
        mapView.hidden = false
    }
    
    @IBAction func cancelMapBtn(sender: UIButton) {
        mapView.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let id = selectedBarber["id"] as! String
        let url = NSURL(string: "http://www.livechairapp.com.php56-33.ord1-1.websitetestlink.com/public/img/barbers/\(id).jpg")
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let data = NSData(contentsOfURL: url!) { //make sure your image in this url does exist, otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    self.bgImg.image = UIImage(data: data)
                });
            }
        }
        
        barberLbl.text = selectedBarber["shop"] as? String
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
