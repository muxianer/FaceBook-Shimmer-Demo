//
//  ViewController.swift
//  Facebook Shimmer Demo
//
//  Created by Arivn Ren on 15/8/4.
//  Copyright (c) 2015年 Arivn Ren. All rights reserved.
//


import UIKit
import QuartzCore

class ViewController: UIViewController {
    var timer: NSTimer!
    var dateFormatter: NSDateFormatter!
    @IBOutlet var clockLabel: UILabel!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var shimmeringView: FBShimmeringView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateClock"), userInfo: nil, repeats: true)
        dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        shimmeringView.contentView = clockLabel
        shimmeringView.shimmering = true
        
        
        // 两次划过之间的时间间隔
        shimmeringView.shimmeringPauseDuration = 1
        // 高亮划过时的不透明度
        shimmeringView.shimmeringAnimationOpacity = 0.5
        // 不透明度
        shimmeringView.shimmeringOpacity = 1.0
        // 高亮部分滑动的速度
        shimmeringView.shimmeringSpeed = 250
        // 高亮部分的宽度
        shimmeringView.shimmeringHighlightLength = 1.0
        // 高亮部分滑动的方向
        shimmeringView.shimmeringDirection = FBShimmerDirection.Right
        
        //FBShimmerDirection.Right,  Shimmer animation goes from left to right
        //FBShimmerDirection.Left,  Shimmer animation goes from right to left
        //FBShimmerDirection.Up,  Shimmer animation goes from below to above
        //FBShimmerDirection.Down,  Shimmer animation goes from above to below
        
        shimmeringView.shimmeringBeginFadeDuration = 0.1
        shimmeringView.shimmeringEndFadeDuration = 0.3
    }
    
    override func viewWillAppear(animated: Bool) {
        updateClock()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 每次要显示这个页面之前重置时间
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // 页面在显示期间不允许重置时间
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    // 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func updateClock() {
        var timeToDisplay = dateFormatter.stringFromDate(NSDate())
        clockLabel.text = timeToDisplay
    }
    
    // 点击屏幕时调用
    @IBAction func didTapView() {
        
        tapGestureRecognizer.enabled = false
        // 切换状态
        shimmeringView.shimmering = !shimmeringView.shimmering
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
            // label显示的内容放大
            self.clockLabel.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }, completion: { (finished) -> Void in
                UIView.animateWithDuration(0.25, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
                    
                    self.clockLabel.transform = CGAffineTransformIdentity
                    }, completion: {
                        (finished) -> Void in
                        self.tapGestureRecognizer.enabled = true
                })
        })
    }
}

