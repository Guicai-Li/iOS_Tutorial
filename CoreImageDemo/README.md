# CoreImageDemo

[Core Image Tutorial: Getting Started](http://www.raywenderlich.com/76285/beginning-core-image-swift)

##笔记
### Core Image

### 什么是Core Image？

Core Image 是用来做图像处理，可以将Core Graphics, Core Video 和 Image I/O 中的图像数据通过 GPU 或者 CPU渲染。Core Image提供了最简单的API接口实现，不需要会OpenGL，也不需要了解OpenGL如何调用GPU去渲染的，更不需要知道如何通过GCD渲染。

### Core Image能做什么？

Core Image 提供：

- Access to built-in image processing filters.

- Feature detection capability.

- Support for automatic image enhancement.

- The ability to chain multiple filters together to create custom effects.

笼统点说：Core Image 很强大，在 Mac OX 上提供了 169 个内置滤镜，在 iOS 上提供了 127 个内置滤镜。

Core Image就好比一个大染坊

![大染坊](./image/DyeHouse.jpg)

在这个大染坊里，每一个CIFilter都是一个大染缸，而我们提供的Image Data就好比胚布。我们按照原定的计划，先从这个染缸里染色，染完后，再去另一个染缸染...直到合适的时候，我们便将这些染好的胚布拉出去晒晒～


### Core Image怎么玩？

> 上面流程用通俗的语言讲了一番，那落实到代码上，该如何实现呢？
	
1.输入源:之前介绍过，可以是Core Graphics, Core Video 或者 Image I/O等Image Data
	
2.确定滤镜:苹果官方提供了滤镜效果详见：[Core Image Filter Reference](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMotionBlur)
	
3.输出:利用CIContext将处理完的图片导出

demo:

		let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png")
        
        beginImage = CIImage(contentsOfURL: fileURL!)
        
        filter = CIFilter(name: "CISepiaTone")!
    
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        
        context = CIContext(options: nil)
        
        let cgimg = context.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        let newImage = UIImage(CGImage: cgimg)
        
        self.imageView.image = newImage

##相关资料链接：
[About Core Image](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html#//apple_ref/doc/uid/TP30001185)

[Core Image 介绍](http://objccn.io/issue-21-6/)


