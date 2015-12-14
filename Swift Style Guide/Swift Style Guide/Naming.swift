//
//  Naming.swift
//  Swift Style Guide
//
//  Created by 力贵才 on 15/12/14.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

// 私有变量
private let maximumWidgetCount = 100

// 枚举
enum Enumeration{
    case Rectangle
    case Square
    case Triangle
    case Circle
}


class Naming : NSObject {
    // 命名规范：易懂
    var widgetButton: UIButton
    var widgetHeightPercentage : Double{
        get{
            return self.widgetHeightPercentage
        }
        set(newValue){
            self.widgetHeightPercentage = newValue
        }
    }
    
    // 定义一个Class必须要有init初始化方法
    override init() {
        widgetButton = UIButton(type: .System)
    }
    
    // 函数
    
    // 函数参数都有一个外部参数名(external parameter name)和一个本地参数名(local parameter name)。
    // 外部参数名用来标记传递给函数调用的参数，本地参数名在实现函数的时候使用。
    // EX: func 函数名(外部参数名 本地参数名:类型)->返回值 {}
    
    // 使用_忽略外部参数名
    func dateFromString(dateString: String!) -> NSDate! {
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        return dateFormatter.dateFromString(dateString)
    }
    
    func convertPointAt(column column: Int, _ row: Int) -> CGPoint {
        return CGPoint(x: column, y: row)
    }
    
    // 修改用户Text Editing习惯
    // tab2格
    // 缩进2格
}


class Shape : NSObject {
    
    override init() {
        
    }
    
    func computeArea() -> Double {
        return 0.0
    }
}

class Circle: Shape {
    var x: Int, y: Int
    var radius: Double
    var diameter: Double {
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
    
    init(x: Int, y: Int, radius: Double) {
        self.x = x
        self.y = y
        self.radius = radius
    }
    
    convenience init(x: Int, y: Int, diameter: Double) {
        self.init(x: x, y: y, radius: diameter / 2)
    }
    
    func describe() -> String {
        return "I am a circle at \(centerString()) with an area of \(computeArea())"
    }
    
    override func computeArea() -> Double {
        return M_PI * radius * radius
    }
    
    private func centerString() -> String {
        return "(\(x),\(y))"
    }
    
    // 代码注释
    // MARK: -
    // FIXME: -
    // TODO: 
    
    
    
}


