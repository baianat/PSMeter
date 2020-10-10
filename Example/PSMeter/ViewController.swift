//
//  ViewController.swift
//  PSMeter
//
//  Created by development@baianat.com on 10/09/2020.
//  Copyright (c) 2020 development@baianat.com. All rights reserved.
//

import UIKit
import PSMeter

class ViewController: UIViewController {

    @IBOutlet weak var psMeter: PSMeter!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func passwordAction(_ sender: Any) {
        let password = sender as? UITextField
        psMeter.updateStrengthIndication(password: password?.text ?? "")
    }
    
}

