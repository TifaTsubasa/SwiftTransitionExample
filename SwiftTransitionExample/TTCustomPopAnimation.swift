//
//  TTCustomPopAnimation.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTCustomPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! TTCustomSecondController
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! TTCustomFirstController
        let selectedCell = toVc.collection.cellForItemAtIndexPath(toVc.selectedIndex!) as! TTThingCell
        let snapImgView = fromVc.imgView.snapshotViewAfterScreenUpdates(false)
        
        let duration = self.transitionDuration(transitionContext)
        let startFrame = fromVc.view.convertRect(fromVc.imgView.frame, toView: containerView)
        let finalFrame = selectedCell.imgView.convertRect(selectedCell.imgView.frame, toView: containerView)
        
        snapImgView.frame = startFrame
        fromVc.imgView.hidden = true
        toVc.view.alpha = 0
        
        containerView?.insertSubview(toVc.view, belowSubview: fromVc.view)
        containerView?.addSubview(snapImgView)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            toVc.view.alpha = 1
            fromVc.view.alpha = 0
            snapImgView.frame = finalFrame
            }) { (finished) -> Void in
                fromVc.imgView.hidden = false
                selectedCell.imgView.hidden = false
                snapImgView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
