//
//  ViewController.swift
//  Circle Progress Indicator
//
//  Created by Warren Hansen on 8/3/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let progressShape = CAShapeLayer()
    let backgroundShape = CAShapeLayer()
    var percent = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(backgroundShape)
        view.layer.addSublayer(progressShape)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateIndicator(with: percent, isAnimated: true)
    }

    func updateIndicator(with percent: Double, isAnimated: Bool = false) {
        let shortestSide = min(view.frame.size.width, view.frame.size.height)
        let strokeWidth: CGFloat = 40.0
        let frame = CGRect(x: 0, y: 0, width: shortestSide - strokeWidth, height: shortestSide - strokeWidth)
        backgroundShape.frame = frame
        backgroundShape.path = UIBezierPath(ovalIn: backgroundShape.frame).cgPath
        backgroundShape.position = view.center
        backgroundShape.strokeColor = UIColor.black.cgColor
        backgroundShape.lineWidth = strokeWidth
        backgroundShape.fillColor = UIColor.clear.cgColor
        
        progressShape.frame = frame
        progressShape.path = backgroundShape.path
        progressShape.position = backgroundShape.position
        progressShape.strokeColor = UIColor.red.cgColor
        progressShape.lineWidth = backgroundShape.lineWidth
        progressShape.fillColor = UIColor.clear.cgColor
        progressShape.strokeEnd = CGFloat(percent)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = progressShape.strokeEnd
        animation.toValue = percent/100.0
        animation.duration = 2.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        if isAnimated {
            progressShape.add(animation, forKey: nil)
        }
    }
}

