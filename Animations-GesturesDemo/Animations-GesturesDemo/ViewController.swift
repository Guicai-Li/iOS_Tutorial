//
//  ViewController.swift
//  Animations-GesturesDemo
//
//  Created by 力贵才 on 15/12/15.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var dieCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image1 = UIImage(named:"penguin_walk01")!
        let image2 = UIImage(named:"penguin_walk02")!
        let image3 = UIImage(named:"penguin_walk03")!
        let image4 = UIImage(named:"penguin_walk04")!
        
        let images = [image1, image2, image3, image4]
        
    
        // 图片组
        imageView.animationImages = images
        
        // 动画周期
        imageView.animationDuration = 1.0
        
        // 动画重复次数
        imageView.animationRepeatCount = 2
        
        
        // 手势
        
        // 右滑
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: "swipeGestureRight:")
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeGestureRight)
        
        // 左滑
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: "swipeGestureLeft:")
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(swipeGestureLeft)
        
        // 点击
        let tap = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tap)
        
        
        // 长按
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        view.addGestureRecognizer(longPress)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - 右滑
    func swipeGestureRight(swipeGestureRight:UISwipeGestureRecognizer) {
        print("右滑")
        
        if (self.imageView.center.x > self.view.frame.size.width) {
            self.imageView.center = CGPointMake(0, self.imageView.center.y);
        }
        
        self.imageView.transform = CGAffineTransformIdentity;
        
        imageView.startAnimating()
        
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            
            self.imageView.center = CGPointMake(self.imageView.center.x + 30, self.imageView.center.y)
            
        })
    }
    
    // MARK: - 左滑
    func swipeGestureLeft(swipeGestureLeft:UISwipeGestureRecognizer) {
        print("左滑")
        
        // 边界控制
        if (imageView.center.x < 0.0) {
            imageView.center = CGPointMake(view.frame.size.width, imageView.center.y);
        }
        
        // 旋转
        self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
        imageView.startAnimating()
        
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            
            self.imageView.center = CGPointMake(self.imageView.center.x - 30, self.imageView.center.y);
            
        })
    }
    
    // MARK: - 点击
    func tap(tap:UITapGestureRecognizer) {
        print("点击")
        
        imageView.startAnimating()
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.imageView.center = CGPointMake(self.imageView.center.x, self.imageView.center.y - 50)
            
            }, completion: { (finished: Bool) -> Void in
                
                self.jumpBack()
        })
    }
    
    // MARK: - 长按
    func longPress(longPress:UILongPressGestureRecognizer) {
        print("长按")
        
        UIView.animateWithDuration(0.33, animations: { () -> Void in
            
            self.dieCenter = self.imageView.center
            self.imageView.center = CGPointMake(self.imageView.center.x, self.view.frame.size.height)
            
            }, completion: { (finished: Bool) -> Void in
                
                self.longPressBack()
        })

    }
    
    
    // MARK: - private
    
    private func jumpBack() {
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.imageView.center = CGPointMake(self.imageView.center.x, self.imageView.center.y + 50)
            
        })
        
    }

    
    func longPressBack() {
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.imageView.center = self.dieCenter!
            
        })
        
    }
}

