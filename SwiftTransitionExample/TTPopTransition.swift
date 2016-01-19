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
        UIView.animateWithDuration(duration, animations: { () -> Void in
            fromVc?.view.frame = CGRectMake(screenW, 0, screenW, screenH)
            toVc?.view.transform = CGAffineTransformMakeScale(1, 1)
            }) { (_) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
