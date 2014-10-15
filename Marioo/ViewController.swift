//
//  ViewController.swift
//  Marioo
//
//  Created by DuyNT on 10/3/14.
//  Copyright (c) 2014 DuyNT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mario: UIImageView?
    var city1, city2, city3, city4, box: UIImageView?
    var _timer: NSTimer?
    var viewHeight: Double = 0.0
    var moveX = 20
    let cityWidth: Double = 1498
    let cityHeight: Double = 400
    let boxWidth: Double = 60
    let boxHeiht: Double = 60
    var viewSize: CGSize!
    var x: Double = 0.0
    var y: Double = 0.0
    var velY: Double = 0.0
    var accY: Double = 4.0
    var count: UILabel!
    var number: Int = 1
    var massenger: UIAlertView!

    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        viewSize = self.view.bounds.size
        viewHeight = Double(viewSize.height) - 60

        city1 = UIImageView(frame: CGRect(x: 0, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city1!.image = UIImage(named: "city1.png")
        self.view.addSubview(city1!)
        
        city4 = UIImageView(frame: CGRect(x: cityWidth, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city4!.image = UIImage(named: "city3.png")
        self.view.addSubview(city4!)
        
        count = UILabel(frame: CGRect(x: viewSize.width * 0.7, y: viewSize.height - 60, width: 50, height: 50))
        count!.text = "0"
        count!.textColor = UIColor.blackColor()
        count!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(count!)
        
        mario = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 102))
        mario?.center = CGPoint(x: viewSize.width * 0.4, y: CGFloat(viewHeight) - 10 - mario!.bounds.size.height * 0.5)
        // cấu hình để UIImage nhận tương tác va chạm. bình thường ko có
        mario!.userInteractionEnabled = true
        mario!.multipleTouchEnabled = false
        
        mario!.animationImages = [
            UIImage(named: "1.png"),
            UIImage(named: "2.png"),
            UIImage(named: "3.png"),
            UIImage(named: "4.png"),
            UIImage(named: "5.png"),
            UIImage(named: "6.png"),
            UIImage(named: "7.png"),
            UIImage(named: "8.png")
        ]
        mario!.animationDuration = 1
        self.view.addSubview(mario!)
        mario!.startAnimating()
        // gắn bộ nhận dạng tương tác chạm (tap) vào madio
        let tap = UITapGestureRecognizer(target: self, action: "tapOnMario")
        mario!.addGestureRecognizer(tap)
        
        box = UIImageView(frame: CGRect(x: boxWidth, y: viewHeight - boxHeiht - 20, width: boxWidth, height: boxHeiht))
        box!.image = UIImage(named: "box.png")
        self.view.addSubview(box!)

        self._timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "runCity:", userInfo: nil, repeats: true)
        self._timer?.fire()
        
    }
    func runCity(nstimer: NSTimer) {
        city1!.center = CGPoint(x: city1!.center.x - CGFloat(moveX), y: city1!.center.y)
        city4!.center = CGPoint(x: city4!.center.x - CGFloat(moveX), y: city4!.center.y)
        box!.center = CGPoint(x: box!.center.x - CGFloat(moveX), y: box!.center.y)
        
        if city1!.frame.origin.x + CGFloat(cityWidth) < 0 {
            city1!.frame = CGRect(x: Double(city4!.frame.origin.x) + cityWidth, y: Double(city1!.frame.origin.y), width: cityWidth, height: cityHeight)
            box!.frame = CGRect(x: 300, y: Double(box!.frame.origin.y), width: boxWidth, height: boxHeiht)
        }
        if city4!.frame.origin.x + CGFloat(cityWidth) < 0 {
            city4!.frame = CGRect(x: Double(city1!.frame.origin.x) + cityWidth, y: Double(city1!.frame.origin.y), width: cityWidth, height: cityHeight)
            box!.frame = CGRect(x: 300, y: Double(box!.frame.origin.y), width: boxWidth, height: boxHeiht)
        }
        if (box!.center.x - CGFloat(moveX) == mario!.center.x){
            count!.text = NSString(format: "%d", number++)
            
        }
        if CGRectIntersectsRect(mario!.frame, box!.frame){
            println("\(number + 1)")
            massenger = UIAlertView(title: NSString(format: "You have %d", number - 1), message: "Game Over", delegate: self.navigationController?.popToRootViewControllerAnimated(true), cancelButtonTitle: "OK")
            massenger.show()
            
            nstimer.invalidate()
            mario!.stopAnimating()
            mario!.image = UIImage(named: "1.png")
            self.view.addSubview(mario!)
            mario!.transform = CGAffineTransformMakeRotation(CGFloat(M_SQRT2 * 3))

        }
//        else {
//            count!.text = NSString(format: "%d", number++)
//        }
    }
    
    
    func tapOnMario() {
        var nsTime = NSTimer.scheduledTimerWithTimeInterval(2.1, target: self, selector: "marioNhay:", userInfo: nil, repeats: true)
        nsTime.fire()
        
    }
    func marioNhay(sender: NSTimer){
        UIView.animateWithDuration(0.9, animations: {
            self.mario!.center = CGPointMake(self.viewSize.width * 0.4, 400)
            self.mario!.stopAnimating()
            self.mario!.image = UIImage(named: "1.png")
            self.view.addSubview(self.mario!)

            }, completion: {
                bool in
                UIView.animateWithDuration(0.5, animations: {
                    self.mario!.center = CGPoint(x: self.viewSize.width * 0.4, y: CGFloat(self.viewHeight) - 10 - self.mario!.bounds.size.height * 0.5)
                        self.mario!.startAnimating()
                    }, completion: {
                        finishes in
                        sender.invalidate()
                })
        })
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        _timer?.invalidate()
        _timer = nil
    }}

