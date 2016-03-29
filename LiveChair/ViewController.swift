//
//  ViewController.swift
//  LiveChair
//
//  Created by Antonio Tangarife on 3/14/16.
//  Copyright © 2016 LiveChair. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        self.navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        let navBarLineView = UIView(frame: CGRectMake(0,
                CGRectGetHeight((navigationController?.navigationBar.frame)!),
                CGRectGetWidth((self.navigationController?.navigationBar.frame)!),
                1))
            navBarLineView.backgroundColor = UIColor.whiteColor()
        
        navigationController?.navigationBar.addSubview(navBarLineView)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
}