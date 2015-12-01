//
//  ViewController.swift
//  CoreImageDemo
//
//  Created by 力贵才 on 15/12/1.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
        CIFilter 滤镜
    */
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png")
        
        let beginImage = CIImage(contentsOfURL: fileURL!)
        
        let filter = CIFilter(name: "CISepiaTone")!
    
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        
//        let newImage = UIImage(CIImage: filter.outputImage!)
//        
//        self.imageView.image = newImage
        
        let context = CIContext(options: nil)
        
        let cgimg = context.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        let newImage = UIImage(CGImage: cgimg)
        
        self.imageView.image = newImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

