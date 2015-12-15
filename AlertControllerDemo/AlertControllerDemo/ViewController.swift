//
//  ViewController.swift
//  AlertControllerDemo
//
//  Created by 力贵才 on 15/12/15.
//  Copyright © 2015年 Guicai.Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlertBtnClicked(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "标题",
                                                message: "这是一条弹出消息",
                                                preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            print("点击确认")
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: false, completion: nil)
        
    }
    
    
    @IBAction func showActionSheetBtnClicked(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "标题",
                                                message: "这是一条弹出消息",
                                                preferredStyle: .ActionSheet)
        let okAction = UIAlertAction(title: "确认", style: .Default) { (action:UIAlertAction) -> Void in
            print("点击确认")
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: false, completion: nil)
        
    }
    
    
    @IBAction func alertWithFormBtnClicked(sender: AnyObject) {
        let alertController = UIAlertController(title: "登录",
                                                message: "请输入密码",
                                                preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action:UIAlertAction!) in
            print("点击取消");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "登录", style: .Default) { (action:UIAlertAction!) in
            print("点击登陆");
        }
        alertController.addAction(OKAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        self.presentViewController(alertController, animated: false, completion: nil)
    }

}

