//
//  TTFirstToSecondAnimation.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTFirstToSecondAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! TTSecondController
        let cell = fromVc.collection.cellForItemAtIndexPath((fromVc.collection.indexPathsForSelectedItems()?.first)!) as! TTThingCell
        let snapImageView = cell.imgView.snapshotViewAfterScreenUpdates(false)
        
        let duration = self.transitionDuration(transitionContext)
        let startFrame = cell.imgView.superview!.convertRect(cell.imgView.frame, toView: containerView)
        let finalFrame = toVc.view.convertRect(toVc.imgView.frame, toView: containerView)
        
        snapImageView.frame = startFrame
        cell.imgView.hidden = true
        toVc.view.alpha = 0
        toVc.imgView.hidden = true
        
        containerView?.addSubview(toVc.view)
        containerView?.addSubview(snapImageView)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            toVc.view.alpha = 1
            snapImageView.frame = finalFrame
            }) { (finished) -> Void in
                toVc.imgView.hidden = false
                cell.hidden = false
                snapImageView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
