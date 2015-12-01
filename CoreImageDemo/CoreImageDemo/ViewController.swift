//
//  ViewController.swift
//  CoreImageDemo
//
//  Created by 力贵才 on 15/12/1.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /*
        CIFilter 滤镜
    */
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var amountSlider: UISlider!
    var context : CIContext!
    var filter : CIFilter!
    var beginImage : CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png")
        
        beginImage = CIImage(contentsOfURL: fileURL!)
        
        filter = CIFilter(name: "CISepiaTone")!
    
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        
//        let newImage = UIImage(CIImage: filter.outputImage!)
//        
//        self.imageView.image = newImage
        
        context = CIContext(options: nil)
        
        let cgimg = context.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        let newImage = UIImage(CGImage: cgimg)
        
        self.imageView.image = newImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func amountSliderValueChanged(sender: AnyObject) {
        
        var slider = sender as! UISlider
        
        let sliderValue = slider.value
        
        filter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        
        let outputImg = filter.outputImage
        
        let cgImg = context.createCGImage(outputImg!, fromRect: outputImg!.extent)
        
        let newImg = UIImage(CGImage: cgImg)
        
        self.imageView.image = newImg
        
    }
    
    @IBAction func loadPhoto(sender: AnyObject) {
        let pickerC = UIImagePickerController()
        pickerC.delegate = self
        self.presentViewController(pickerC, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("[line=83]image=\(image), info=\(editingInfo)")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            print("[line=87]info=\(info)")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let gotImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        beginImage = CIImage(image: gotImg)
        
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        
        self.amountSliderValueChanged(self.amountSlider) //好机智...
    }
}

