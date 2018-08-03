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
    
    @IBOutlet weak var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.layer.addSublayer(backgroundShape)
        circleView.layer.addSublayer(progressShape)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateIndicator(with: percent, isAnimated: false)
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        let currentValue = sender.value
        let mStr = String(format: "%.1f", currentValue)
        print("New Slider Value \(mStr)")
        updateIndicator(with: Double(currentValue), isAnimated: false)
    }
    

    func updateIndicator(with percent: Double, isAnimated: Bool = false) {

        let strokeWidth: CGFloat = 15.0
        backgroundShape.frame = circleView.bounds
        backgroundShape.path = UIBezierPath(ovalIn: backgroundShape.frame).cgPath
        // backgroundShape.position = circleView.center
        backgroundShape.strokeColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        backgroundShape.lineWidth = strokeWidth
        backgroundShape.lineDashPattern = [3]
        backgroundShape.fillColor = UIColor.clear.cgColor
        progressShape.frame = circleView.bounds
        progressShape.path = backgroundShape.path
        progressShape.position = backgroundShape.position
        progressShape.strokeColor = UIColor.white.cgColor
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

