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
    
    var snap : UISnapBehavior!
    var square : UIView!

    var firstContact = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
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
            print("\(NSStringFromCGAffineTransform(self.square.transform)) \(NSStringFromCGPoint(self.square.center))")
        }
        
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        itemBehaviour.elasticity = 0.6
        itemBehaviour.density = 30
        animator.addBehavior(itemBehaviour)
        
        /*
            介绍几个属性：
            elasticity：弹性系数 // Usually between 0 (inelastic) and 1 (collide elastically) 
            friction：摩擦系数 0 being no friction between objects slide along each other
            density：质量 1 by default
            resistance：阻力系数 0: no velocity damping
            angularResistance：旋转系数 0: no angular velocity damping
            allowsRotation：是否能旋转
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UICollisionBehaviorDelegate
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        print("behavior: \(behavior) item:\(item) identifier:\(identifier) point:\(p)")
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellowColor()
        UIView.animateWithDuration(0.3) {
            collidingView.backgroundColor = UIColor.grayColor()
        }
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

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        let touch = touches.first
        snap = UISnapBehavior(item: square, snapToPoint: touch!.locationInView(view))
        animator.addBehavior(snap)
    }
}

