//
//  ViewController.swift
//  BaseVCKit
//
//  Created by seongkyu-sim on 04/19/2017.
//  Copyright (c) 2017 seongkyu-sim. All rights reserved.
//

import UIKit
import BaseVCKit

class ViewController: UIViewController, NavButtonConfigurable {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print("viewDidLoad, presentStatus.rawValue: \(presentStatus.rawValue)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear, presentStatus.rawValue: \(presentStatus.rawValue)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

