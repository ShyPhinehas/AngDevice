//
//  ViewController.swift
//  AngDevice
//
//  Created by skyphinehas@hanmail.net on 08/31/2017.
//  Copyright (c) 2017 skyphinehas@hanmail.net. All rights reserved.
//

import UIKit
import AngDevice

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(AngDevice.current.deviceType)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

