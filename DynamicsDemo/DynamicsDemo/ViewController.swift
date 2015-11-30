//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by 力贵才 on 15/11/30.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
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
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.redColor()
        view.addSubview(barrier)
        
        // 思考？从目前看到的效果来说，并没有产生任何物理碰撞，那如何才能产生碰撞效果？
        // 重点：Dynamic－Behavior 必须产生关联才能产生物理效果
        
        collision = UICollisionBehavior(items: [square, barrier])
        animator.addBehavior(collision)
        
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        collision.action = {
            print("\(NSStringFromCGAffineTransform(square.transform)) \(NSStringFromCGPoint(square.center))")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UICollisionBehaviorDelegate
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        print("behavior: \(behavior) item:\(item) identifier:\(identifier) point:\(p)")
        
    }

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        print("behavior: \(behavior) item1:\(item1) item2:\(item2) point:\(p)")
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        print("behavior: \(behavior) item:\(item) identifier:\(identifier)")
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem) {
        print("behavior: \(behavior) item1:\(item1) item2:\(item2)")
    }

}

