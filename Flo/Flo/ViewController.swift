//
//  ViewController.swift
//  Flo
//
//  Created by 力贵才 on 15/12/2.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterView: CounterView!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPushButton(sender: AnyObject) {
        
        counterView.counter++
        counterLabel.text = String(counterView.counter)
    }

}

