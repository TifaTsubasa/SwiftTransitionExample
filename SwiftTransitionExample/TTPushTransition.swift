//
//  TTPushTransition.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/19.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: .from)
        let toVc = transitionContext.viewController(forKey: .to)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        containerView.addSubview((toVc?.view)!)
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        toVc?.view.frame = CGRect(x: screenW, y: 0, width: screenW, height: screenH)
        
        // shadows
        toVc?.view.layer.shadowOffset = CGSize(width: -3, height: 0);
        toVc?.view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        toVc?.view.layer.shadowOpacity = 1
        
        // cover view
        
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0
        containerView.insertSubview(blackView, belowSubview: toVc!.view)
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            fromVc?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            toVc?.view.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH)
            blackView.alpha = 0.7
            }) { (_) -> Void in
                blackView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
