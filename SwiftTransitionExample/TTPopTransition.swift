//
//  TTPopTransition.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/19.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: .from)
        let toVc = transitionContext.viewController(forKey: .to)
        
        
        let duration = self.transitionDuration(using: transitionContext)
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        containerView.addSubview(toVc!.view)
        containerView.addSubview(toVc!.view)
        containerView.sendSubviewToBack(toVc!.view)
        
        // cover view
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0.7
        containerView.insertSubview(blackView, belowSubview: fromVc!.view)
        
        UIView.animate(withDuration: duration, animations: {
            fromVc?.view.frame = CGRect(x: screenW, y: 0, width: screenW, height: screenH)
            
            toVc?.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            blackView.alpha = 0
        }) { (finish) in
            blackView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
