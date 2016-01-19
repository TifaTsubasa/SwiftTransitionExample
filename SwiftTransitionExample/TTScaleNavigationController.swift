//
//  TTScaleNavigationController.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/19.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTScaleNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var interactivePopTransition: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
        let popRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handlePopRecognizer:")
        popRecognizer.edges = .Left;
        self.view.addGestureRecognizer(popRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .Push) {
            return TTPushTransition()
        } else if operation == .Pop {
            return TTPopTransition()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivePopTransition
    }
    
    func handlePopRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = recognizer.translationInView(self.view).x / self.view.bounds.width
        progress = min(1.0, max(0.0, progress))
        
        if recognizer.state == .Began {
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.popViewControllerAnimated(true)
        } else if recognizer.state == .Changed {
            interactivePopTransition?.updateInteractiveTransition(progress)
        } else if recognizer.state == .Ended || recognizer.state == .Cancelled {
            if progress > 0.5 {
                interactivePopTransition?.finishInteractiveTransition()
            } else {
                interactivePopTransition?.cancelInteractiveTransition()
            }
            interactivePopTransition = nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
