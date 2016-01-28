//
//  TTPushTransition.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/19.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let duration = self.transitionDuration(transitionContext)
        
        containerView?.addSubview((toVc?.view)!)
        let screenW = UIScreen.mainScreen().bounds.width
        let screenH = UIScreen.mainScreen().bounds.height
        toVc?.view.frame = CGRectMake(screenW, 0, screenW, screenH)
        
        // shadows
        toVc?.view.layer.shadowOffset = CGSizeMake(-3, 0);
        toVc?.view.layer.shadowColor = UIColor.redColor().colorWithAlphaComponent(0.3).CGColor
        toVc?.view.layer.shadowOpacity = 1
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            fromVc?.view.transform = CGAffineTransformMakeScale(0.7, 0.7)
            toVc?.view.frame = CGRectMake(0, 0, screenW, screenH)
            fromVc?.view
            }) { (_) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
