//
//  TTCustomPushAnimation.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTCustomPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: .from) as! TTCustomFirstController
        let toVc = transitionContext.viewController(forKey: .to) as! TTCustomSecondController
        
        let cell = fromVc.collection.cellForItem(at: (fromVc.collection!.indexPathsForSelectedItems?.first!)!) as! TTThingCell
        let snapImageView = cell.imgView.snapshotView(afterScreenUpdates: false)
        
        let duration = self.transitionDuration(using: transitionContext)
        let startFrame = cell.imgView.superview!.convert(cell.imgView.frame, to: containerView)
        let finalFrame = toVc.view.convert(toVc.imgView.frame, to: containerView)
        
        containerView.addSubview(toVc.view)
        containerView.addSubview(snapImageView!)
        
        snapImageView?.frame = startFrame
        cell.imgView.isHidden = true
        toVc.view.alpha = 0
        toVc.imgView.isHidden = true
        
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            toVc.view.alpha = 1
            snapImageView?.frame = finalFrame
            }) { (finished) -> Void in
                toVc.imgView.isHidden = false
                cell.isHidden = false
                snapImageView?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
