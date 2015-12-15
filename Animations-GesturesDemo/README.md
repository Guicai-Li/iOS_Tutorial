# Animations-GesturesDemo

##笔记

> 这讲主要讲解了UIImageView的图片动画组以及手势的应用。

## 图片动画组

### 图片动画组－animationImages

```Swift
var animationImages: [UIImage]?
```

> 举例：

    let image1 = UIImage(named:"penguin_walk01")!
    let image2 = UIImage(named:"penguin_walk02")!
    let image3 = UIImage(named:"penguin_walk03")!
    let image4 = UIImage(named:"penguin_walk04")!
    
    let images = [image1, image2, image3, image4]

    // 图片组
    imageView.animationImages = images

### 动画周期－animationDuration

```Swift
var animationDuration: NSTimeInterval
```

> 举例：

	imageView.animationDuration = 1.0

### 动画重复次数－animationRepeatCount

```Swift
var animationRepeatCount: Int
```

> 举例：

    imageView.animationRepeatCount = 2
    
## 手势

常见手势:

- 点击：Tap
- 捏合：Pinch
- 拖动：Pan
- 滑动：Swip
- 旋转：Rotation
- 长按：LongPress

### UITapGestureRecognizer

点击次数

```Swift
var numberOfTapsRequired: Int // Default is 1. The number of taps required to match
```
点击时，相应的手指个数

```Swift
var numberOfTouchesRequired: Int // Default is 1. The number of fingers required to match
```

### UIPinchGestureRecognizer

缩放率

```Swift
var scale: CGFloat // scale relative to the touch points in screen coordinates
```

缩放速度

```Swift
var velocity: CGFloat { get } // velocity of the pinch in scale/second
```

### UIPanGestureRecognizer

最少相应手指个数

```Swift
var minimumNumberOfTouches: Int // default is 1. the minimum number of touches required to match
```

最多响应手指个数

```Swift
var maximumNumberOfTouches: Int // default is UINT_MAX. the maximum number of touches that can be down
```

移动到指定坐标

```Swift
func translationInView(view: UIView?) -> CGPoint // translation in the coordinate system of the specified view
```

```Swift
func setTranslation(translation: CGPoint, inView view: UIView?)
```
移动速率

```Swift
func velocityInView(view: UIView?) -> CGPoint // velocity of the pan in pixels/second in the coordinate system of the specified view
```

### UISwipeGestureRecognizer

点击时，相应的手指个数

```Swift
var numberOfTouchesRequired: Int // default is 1. the number of fingers that must swipe
```

滑动的方向

```Swift
var direction: UISwipeGestureRecognizerDirection // default is UISwipeGestureRecognizerDirectionRight. the desired direction of the swipe. multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete)
```

### UIRotationGestureRecognizer

角度

```Swift
var rotation: CGFloat // rotation in radians
```

速度

```Swift
var velocity: CGFloat { get } // velocity of the pinch in radians/second
```

### 如何使用手势

添加手势

```
func addGestureRecognizer(gestureRecognizer: UIGestureRecognizer)
```
> 举例：

    view.addGestureRecognizer(longPress)

移除手势

```
func removeGestureRecognizer(gestureRecognizer: UIGestureRecognizer)
```

> 举例：
    view.removeGestureRecognizer(longPress)
    
### 用户交互

```Swift
var userInteractionEnabled: Bool // default is YES. if set to NO, user events (touch, keys) are ignored and removed from the event queue.
```

##相关资料链接：

[官方文档](https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html)
