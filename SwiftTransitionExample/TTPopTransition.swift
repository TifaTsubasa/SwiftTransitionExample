//
//  TTPopTransition.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/19.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let duration = self.transitionDuration(transitionContext)
        let screenW = UIScreen.mainScreen().bounds.width
        let screenH = UIScreen.mainScreen().bounds.height
        containerView?.addSubview(toVc!.view)
        containerView?.sendSubviewToBack(toVc!.view)
        
        // cover view
        let blackView = UIView(frame: CGRectMake(0, 0, screenW, screenH))
        blackView.backgroundColor = UIColor.blackColor()
        blackView.alpha = 0.7
        containerView?.insertSubview(blackView, belowSubview: fromVc!.view)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            fromVc?.view.frame = CGRectMake(screenW, 0, screenW, screenH)
            toVc?.view.transform = CGAffineTransformMakeScale(1, 1)
            blackView.alpha = 0
            }) { (_) -> Void in
                blackView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
