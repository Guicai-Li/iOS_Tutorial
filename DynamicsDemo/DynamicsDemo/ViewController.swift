//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by 力贵才 on 15/11/30.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
        UIDynamicAnimator是UIkit的物理引擎。它根据物体指定的物理效果而产生运动轨迹，比如重力等效果。
    */
    
    var animator: UIDynamicAnimator! // 动力动画
    var gravity: UIGravityBehavior! // 重力
    var collision: UICollisionBehavior! // 碰撞  通过UICollisionBehavior指定一个边界

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.grayColor()
        view.addSubview(square)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        
        /*
            重力效果公式：distance = 0.5 * g * time2; (g = 9.8m/s^2)
        */
        
        collision = UICollisionBehavior(items: [square])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

