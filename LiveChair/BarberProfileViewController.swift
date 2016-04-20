//
//  BarberProfileViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 4/20/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import UIKit

class BarberProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var profileImg: UIImageView!
    let imagePicker = UIImagePickerController()
    
    @IBAction func changePictureBtn(sender: UIButton) {
        imagePicker.editing = false
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImg.contentMode =  .ScaleAspectFit
            profileImg.image = pickedImage
            myImageUploadRequest()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func myImageUploadRequest()
    {
        
        //let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
        let myUrl = NSURL(string: "http://localhost/livechairapp/out/barber");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "userId"    : "9"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(profileImg.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        //myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
//            var err: NSError?
            
//            do {
  //              var json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
    //        } catch {
      //          print(error)
        //        print(NSString(data: data!, encoding: NSUTF8StringEncoding))
          //  }
            
            
//            dispatch_async(dispatch_get_main_queue(),{
  //              self.myActivityIndicator.stopAnimating()
    //            self.myImageView.image = nil;
      //      });
            
            /*
             if let parseJSON = json {
             var firstNameValue = parseJSON["firstName"] as? String
             println("firstNameValue: \(firstNameValue)")
             }
             */
            
        }
        
        task.resume()
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.xappendString("--\(boundary)\r\n")
                body.xappendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.xappendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.xappendString("--\(boundary)\r\n")
        body.xappendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.xappendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.xappendString("\r\n")
        
        
        
        body.xappendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
    
}



extension NSMutableData {
    
    func xappendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

