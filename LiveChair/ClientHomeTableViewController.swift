//
//  ClientHomeTableViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 3/29/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import UIKit

var selectedBarber:AnyObject = []

extension ClientHomeTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class ClientHomeTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var barbers:Array< AnyObject > = Array < AnyObject >()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        getBarbers("All")
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        //definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return barbers.count
    }
    
    func getBarbers(searchText:String)
    {
        self.barbers.removeAll()
        self.tableView.reloadData()
        
        let searchString = searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! as String
        
        let url = NSURL(string: "http://www.livechairapp.com.php56-33.ord1-1.websitetestlink.com/barber?s=\(searchString)")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:Array< AnyObject >]
                
                if (json["error"] != nil) {
                    dispatch_async(dispatch_get_main_queue(), {
                        print(json["error"])
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        print (json)
                        self.barbers = json["barbers"]!
                        self.tableView.reloadData()
                    })
                }
                
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            }
            
            
        })
        
        task.resume()
    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("barberCell", forIndexPath: indexPath)

        
        let frame = UIView(frame: CGRectMake(0,cell.frame.height-40,cell.frame.width, 40))
        frame.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)
        
        let shop = UILabel(frame: CGRectMake(10,10,cell.frame.width-20,20))
        shop.textColor = UIColor.whiteColor()
        shop.font = UIFont(name: "HeleveticaNeue-Bold", size: 13)
        shop.text = barbers[indexPath.row]["shop"] as? String
        shop.text = shop.text?.uppercaseString
        
        frame.addSubview(shop)
        
        let pic = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
        pic.contentMode = .ScaleAspectFill
        let id = barbers[indexPath.row]["id"] as! String
        let url = NSURL(string: "http://www.livechairapp.com.php56-33.ord1-1.websitetestlink.com/public/img/barbers/\(id).jpg")
        
        print (id)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let data = NSData(contentsOfURL: url!) { //make sure your image in this url does exist, otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    pic.image = UIImage(data: data)
                });
            }
        }
        
        cell.addSubview(pic)
        cell.addSubview(frame)
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
    
        getBarbers(searchText)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier != "UserProfile" {
            let row = self.tableView.indexPathForSelectedRow!.row
            print("row \(row) was selected")
            selectedBarber = barbers[row]
        }
        
    }

}
