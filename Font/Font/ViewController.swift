//
//  ViewController.swift
//  Font
//
//  Created by 力贵才 on 16/2/9.
//  Copyright © 2016年 XSVOI. All rights reserved.
//

// 相关资料：
// labrary : https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIFont_Class/#//apple_ref/occ/clm/UIFont/monospacedDigitSystemFontOfSize:weight:
// stackoverflow : http://stackoverflow.com/questions/30854690/how-to-get-monospaced-numbers-in-uilabel-on-ios-9

import UIKit

extension UIFont {
    
    var monospacedDigitFont: UIFont {
        let oldFontDescriptor = fontDescriptor()
        let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
}

private extension UIFontDescriptor {
    
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [[UIFontFeatureTypeIdentifierKey: kNumberSpacingType, UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptorFeatureSettingsAttribute: fontDescriptorFeatureSettings]
        let fontDescriptor = self.fontDescriptorByAddingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var labelsOnStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fontUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @available(iOS 9.0, *)
    func fontUpdate() {
        
        let labels = labelsOnStackView.subviews as Array
        
        for var i = 0 ; i < labels.count; i++ {
            let label = labels[i] as! UILabel
            // fixed with Xcode 7 beta 4.
            // label.font = label.font.monospacedDigitFont
            
            // UIFont now has the same monospacedDigitsSystemFontOfSize:weight: method as NSFont.
            // @fontSize
            // @weight 0...1
            label.font = UIFont.monospacedDigitSystemFontOfSize(17, weight: 0.1)
        }
        
    }
}

