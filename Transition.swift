//
//  CircularTransition.swift
//  CircularTransition
//
//  Created by Training on 26/08/2016.
//  Copyright © 2016 Training. All rights reserved.
//


import UIKit

extension UIView {
    
    func addCornerRadiusAnimation(from: CGFloat, to: CGFloat, duration: CFTimeInterval)
    {
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        self.layer.add(animation, forKey: "cornerRadius")
        self.layer.cornerRadius = to
    }
}

class CircularTransition: NSObject {
    
    
    
    
    var startingPoint = CGPoint.zero
    
    var circleColor = UIColor.white
    
    var duration = 0.5
    
    enum CircularTransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
}





extension CircularTransition:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let scX = 100 / presentedView.frame.width
                let scY = 200 / presentedView.frame.height
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: scX, y: scY)
                presentedView.layer.cornerRadius = presentedView.frame.width / 100 * 20
                presentedView.layer.masksToBounds = true
                
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.center = viewCenter
                   // presentedView.layer.cornerRadius = 0
                    presentedView.addCornerRadiusAnimation(from: presentedView.frame.width / 100 * 20, to: 0, duration: 0.5)
                    
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                
                let scX = 100 / returningView.frame.width
                let scY = 200 / returningView.frame.height
                let viewCenter = returningView.center
                
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                  
                    let vieww = returningView.frame.width
                    returningView.transform = CGAffineTransform(scaleX: scX, y: scY)
                    returningView.center = self.startingPoint
                    returningView.addCornerRadiusAnimation(from: 0, to: (vieww / 100 * 20) , duration: 0.5)
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        
                    }
                    
                    
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                    
                })
                
            }
            
            
        }
        
    }
    
    
    
    
    
}
