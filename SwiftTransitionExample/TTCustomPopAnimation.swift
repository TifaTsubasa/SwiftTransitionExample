//
//  TTCustomPopAnimation.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTCustomPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        
        let fromVc = transitionContext.viewController(forKey: .from) as! TTCustomSecondController
        let toVc = transitionContext.viewController(forKey: .to) as! TTCustomFirstController
        
        let selectedCell = toVc.collection.cellForItem(at: toVc.selectedIndex! as IndexPath) as! TTThingCell
        let snapImgView = fromVc.imgView.snapshotView(afterScreenUpdates: false)
        
        let duration = transitionDuration(using: transitionContext)
        let startFrame = fromVc.view.convert(fromVc.imgView.frame, to: containerView)
        let finalFrame = selectedCell.imgView.convert(selectedCell.imgView.frame, to: containerView)
        
        snapImgView?.frame = startFrame
        fromVc.imgView.isHidden = true
        toVc.view.alpha = 0
        
        containerView.insertSubview(toVc.view, belowSubview: fromVc.view)
        containerView.addSubview(snapImgView!)
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            toVc.view.alpha = 1
            fromVc.view.alpha = 0
            snapImgView?.frame = finalFrame
            }) { (finished) -> Void in
                fromVc.imgView.isHidden = false
                selectedCell.imgView.isHidden = false
                snapImgView?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
