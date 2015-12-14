# 关于Swift的代码规范

参考原文来自：[The official Swift style guide for raywenderlich.com.](https://github.com/raywenderlich/swift-style-guide#prose)

## 目录

* [命名规范](#命名规范)
  * [Prose](#prose)
  * [关于引入模块](#关于引入模块)
* [空格以及换行缩进](#空格以及换行缩进)
* [注释](#注释)
* [类与结构体](#类与结构体)
  * [Self的使用](#Self的使用)
  * [Protocol协议的优美写法](#Protocol协议的优美写法)
  * [计算属性](#计算属性)
* [函数声明](#函数声明)
* [闭包](#闭包)
* [类型](#类型)
  * [常量](#常量)
  * [Optionals](#optionals)
  * [结构体初始化](#结构体初始化)
  * [类型推断](#类型推断)
  * [Syntactic Sugar](#syntactic-sugar)
* [Control Flow](#control-flow)
* [Semicolons](#semicolons)
* [关于英语](#关于英语)


## 命名规范

建议使用描述性的方式命名类、方法、变量等。类名需要遵循驼[峰式结构](https://zh.wikipedia.org/wiki/%E9%A7%9D%E5%B3%B0%E5%BC%8F%E5%A4%A7%E5%B0%8F%E5%AF%AB),首字母大写，而方法名、变量名则以小写字母开始。

**推荐:**

```swift
private let maximumWidgetCount = 100

class WidgetContainer {
  var widgetButton: UIButton
  let widgetHeightPercentage = 0.85
}
```

**不推荐:**

```swift
let MAX_WIDGET_COUNT = 100

class app_widgetContainer {
  var wBut: UIButton
  let wHeightPct = 0.85
}
```

针对函数和初始化方法中的参数列表，除非参数结构清晰，建议使用外部参数名来使得整个方法看起来非常清楚。


```swift
func dateFromString(dateString: String) -> NSDate
func convertPointAt(column column: Int, row: Int) -> CGPoint
func timedAction(afterDelay delay: NSTimeInterval, perform action: SKAction) -> SKAction!

// would be called like this:
dateFromString("2014-03-14")
convertPointAt(column: 42, row: 13)
timedAction(afterDelay: 1.0, perform: someOtherAction)
```

苹果开发者大会上提到的例子：

```swift
class Counter {
  func combineWith(otherCounter: Counter, options: Dictionary?) { ... }
  func incrementBy(amount: Int) { ... }
}
```

### 枚举

使用enum关键词来创建枚举

```swift
enum Shape {
  case Rectangle
  case Square
  case Triangle
  case Circle
}
```

### Prose

When referring to functions in prose (tutorials, books, comments) include the required parameter names from the caller's perspective or `_` for unnamed parameters.

> Call `convertPointAt(column:row:)` from your own `init` implementation.
>
> If you call `dateFromString(_:)` make sure that you provide a string with the format "yyyy-MM-dd".
>
> If you call `timedAction(afterDelay:perform:)` from `viewDidLoad()` remember to provide an adjusted delay value and an action to perform.
>
> You shouldn't call the data source method `tableView(_:cellForRowAtIndexPath:)` directly.

When in doubt, look at how Xcode lists the method in the jump bar – our style here matches that.

![Methods in Xcode jump bar](screens/xcode-jump-bar.png)

### 关于引入模块

在Swift开发中会自动加载所有模块，通常不需要导入模块。除非当遇到两个模块命名冲突时，可手动引入类，避免冲突。

**推荐:**

```swift
let myClass = MyModule.UsefulClass()
```

**不推荐:**

```swift
import SomeModule

let myClass = MyModule.UsefulClass()
```


## 空格以及换行缩进

* 根据下图设置缩进以及Tab键缩进2个字节：

  ![Xcode indent settings](screens/indentation.png)

* 针对方法或者其他结构(例如：`if`/`else`/`switch`/`while`等)，建议大括号尾随方法后，不建议换行。
* 小技巧: 使用⌘A全选或者只选中部分代码，使用Control-I(或者点击菜单 Editor\Structure\Re-Indent)自动格式化代码。

**推荐:**

```swift
if user.isHappy {
  // Do something
} else {
  // Do something else
}
```

**不推荐:**

```swift
if user.isHappy
{
    // Do something
}
else {
    // Do something else
}
```

* 建议在代码中添加部分注释，使得整体看起来清晰有组织。另外，每个方法负责独立的功能，尽可能降低方法的复杂度。

## 注释

代码总有看不懂的时候，注释还是有必要的。添加适量的注释，可以帮助你的小伙伴解释为什么要这么写？或者在之后的那一年，如果你对这块业务熟烂透了，那就没必要了，但是当你在看到时候，自己都遗忘了这里的逻辑是如何写的，这就体现出注释的重要性了。

关于注释的相关姿势请转步：[Swift Documentation](http://nshipster.cn/swift-documentation/)

## 类与结构体

### 类和结构体的选择

在你的代码中，你可以使用类和结构体来定义你的自定义数据类型。

然而，结构体实例总是通过值传递，类实例总是通过引用传递。这意味两者适用不同的任务。当你在考虑一个工程项目的数据构造和功能的时候，你需要决定每个数据构造是定义成类还是结构体。

按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：

结构体的主要目的是用来封装少量相关简单数据值。
有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
结构体不需要去继承另一个已存在类型的属性或者行为。

> 原文

- Remember, structs have [value semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_144). Use structs for things that do not have an identity. An array that contains [a, b, c] is really the same as another array that contains [a, b, c] and they are completely interchangeable. It doesn't matter whether you use the first array or the second, because they represent the exact same thing. That's why arrays are structs.

- Classes have [reference semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_145). Use classes for things that do have an identity or a specific life cycle. You would model a person as a class because two person objects are two different things. Just because two people have the same name and birthdate, doesn't mean they are the same person. But the person's birthdate would be a struct because a date of 3 March 1950 is the same as any other date object for 3 March 1950. The date itself doesn't have an identity.

- Sometimes, things should be structs but need to conform to `AnyObject` or are historically modeled as classes already (`NSDate`, `NSSet`). Try to follow these guidelines as closely as possible.

### 举个例子

```swift
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
}
```

另外，根据上面的例子，可以总结出以下几点：

 + 格式： 变量名：类型
 + 在同一行上声明变量或者结构体，以逗号分隔，变量类型相同(变量or常量)。
 + getter、setter方法在变量后尾随，换行缩进。
 + 不需要添加`internal `修饰符，默认已添加。类似的，不要重复覆盖修饰符。


### Self的使用

简单来说，尽量避免使用self直接访问属性或者调用方法。

当无法区分属性或者参数时，这时候应该使用self

举个例子：

```swift
class BoardLocation {
  let row: Int, column: Int

  init(row: Int, column: Int) {
    self.row = row
    self.column = column
    
    let closure = {
      println(self.row)
    }
  }
}
```

### Protocol协议的优美写法

当某类遵循协议的时，比较优美的写法，使用扩展，将每个协议与类分离，降低模块之间的耦合度。

**推荐:**

```swift
class MyViewcontroller: UIViewController {
  // class stuff here
}

// MARK: - UITableViewDataSource
extension MyViewcontroller: UITableViewDataSource {
  // table view data source methods
}

// MARK: - UIScrollViewDelegate
extension MyViewcontroller: UIScrollViewDelegate {
  // scroll view delegate methods
}
```

**不推荐:**

```swift
class MyViewcontroller: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
  // all methods
}
```

### 计算属性

如果该属性只为Read-Only，默认遵循getter方法，直接写即可。

**推荐:**
```swift
var diameter: Double {
  return radius * 2
}
```

**不推荐:**
```swift
var diameter: Double {
  get {
    return radius * 2
  }
}
```

## 函数声明

尽可能的保持函数的简短声明：

```swift
func reticulateSplines(spline: [Double]) -> Bool {
  // reticulate code goes here
}
```

当遇到函数名过长时，使用换行并添加额外的缩紧来使得代码看起来优雅。

```swift
func reticulateSplines(spline: [Double], adjustmentFactor: Double,
    translateConstant: Int, comment: String) -> Bool {
  // reticulate code goes here
}
```


## 闭包

使用闭包时，当只有一个参数时，可直接尾随闭包。

**推荐:**

```swift
UIView.animateWithDuration(1.0) {
  self.myView.alpha = 0
}

UIView.animateWithDuration(1.0,
  animations: {
    self.myView.alpha = 0
  },
  completion: { finished in
    self.myView.removeFromSuperview()
  }
)
```

**不推荐:**

```swift
UIView.animateWithDuration(1.0, animations: {
  self.myView.alpha = 0
})

UIView.animateWithDuration(1.0,
  animations: {
    self.myView.alpha = 0
  }) { f in
    self.myView.removeFromSuperview()
}
```

单行表达式闭包可以通过隐藏return关键字来隐式返回单行表达式的结果。

```swift
attendeeList.sort { a, b in
  a > b
}
```


## 类型

尽可能用Swift中的类型，此外，Swift也支持Objective-C，所以仍然可以使用Objective-C中的类型。

**推荐:**

```swift
let width = 120.0                                    // Double
let widthString = (width as NSNumber).stringValue    // String
```

**不推荐:**

```swift
let width: NSNumber = 120.0                          // NSNumber
let widthString: NSString = width.stringValue        // NSString
```

### 常量

定义常量可以使用`let`定义，也可以使用`var`定义。通常使用`let`代替`var`声明常量。

**小技巧:** 默认使用`let`定义任何属性，只有当该属性发生改变时，使用`var`，另外编译器会提示你是否正确。

### Optionals

Declare variables and function return types as optional with `?` where a nil value is acceptable.

Use implicitly unwrapped types declared with `!` only for instance variables that you know will be initialized later before use, such as subviews that will be set up in `viewDidLoad`.

When accessing an optional value, use optional chaining if the value is only accessed once or if there are many optionals in the chain:

```swift
self.textContainer?.textLabel?.setNeedsDisplay()
```

Use optional binding when it's more convenient to unwrap once and perform multiple operations:

```swift
if let textContainer = self.textContainer {
  // do many things with textContainer
}
```

When naming optional variables and properties, avoid naming them like `optionalString` or `maybeView` since their optional-ness is already in the type declaration.

For optional binding, shadow the original name when appropriate rather than using names like `unwrappedView` or `actualLabel`.

**推荐:**

```swift
var subview: UIView?
var volume: Double?

// later on...
if let subview = subview, volume = volume {
  // do something with unwrapped subview and volume
}
```

**不推荐:**

```swift
var optionalSubview: UIView?
var volume: Double?

if let unwrappedSubview = optionalSubview {
  if let realVolume = volume {
    // do something with unwrappedSubview and realVolume
  }
}
```

### 结构体初始化

**推荐:**

```swift
let bounds = CGRect(x: 40, y: 20, width: 120, height: 80)
let centerPoint = CGPoint(x: 96, y: 42)
```

**不推荐:**

```swift
let bounds = CGRectMake(40, 20, 120, 80)
let centerPoint = CGPointMake(96, 42)
```

使用`.zero`来代替`CGRect.infinite`, `CGRect.null`, `CGRectInfinite`, `CGRectNull`等。

### 类型推断

尽可能将代码简化，让编译器推断类型，除非特殊指定类型。例如：`CGFloat`, `Int16` etc.

**推荐:**

```swift
let message = "Click the button"
let currentBounds = computeViewBounds()
var names = [String]()
let maximumWidth: CGFloat = 106.5
```

**不推荐:**

```swift
let message: String = "Click the button"
let currentBounds: CGRect = computeViewBounds()
var names: [String] = []
```

**备注**: 变量名的命名规则尤为重要，最佳的方式，可以通过看变量名确定变量类型。


### Syntactic Sugar

Prefer the shortcut versions of type declarations over the full generics syntax.

**Preferred:**
```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```

**Not Preferred:**
```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```


## Control Flow

Prefer the `for-in` style of `for` loop over the `for-condition-increment` style.

**Preferred:**
```swift
for _ in 0..<3 {
  println("Hello three times")
}

for (index, person) in attendeeList.enumerate() {
  println("\(person) is at position #\(index)")
}
```

**Not Preferred:**
```swift
for var i = 0; i < 3; i++ {
  println("Hello three times")
}

for var i = 0; i < attendeeList.count; i++ {
  let person = attendeeList[i]
  println("\(person) is at position #\(i)")
}
```


## Semicolons

Swift does not require a semicolon after each statement in your code. They are only required if you wish to combine multiple statements on a single line.

Do not write multiple statements on a single line separated with semicolons.

The only exception to this rule is the `for-conditional-increment` construct, which requires semicolons. However, alternative `for-in` constructs should be used where possible.

**Preferred:**
```swift
let swift = "not a scripting language"
```

**Not Preferred:**
```swift
let swift = "not a scripting language";
```

**NOTE**: Swift is very different to JavaScript, where omitting semicolons is [generally considered unsafe](http://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)

## 关于英语

请正确书写英文单词。

**推荐:**

```swift
let color = "red"
```

**不推荐:**

```swift
let colour = "red"
```