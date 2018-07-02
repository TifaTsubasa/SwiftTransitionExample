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
        let popRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePopRecognizer(recognizer:)))
        popRecognizer.edges = .left;
        self.view.addGestureRecognizer(popRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .push) {
            return TTPushTransition()
        } else if operation == .pop {
            return TTPopTransition()
        } else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivePopTransition
    }
    
    @objc func handlePopRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = recognizer.translation(in: self.view).x / self.view.bounds.width
        progress = min(1.0, max(0.0, progress))
        let state: UIGestureRecognizer.State = recognizer.state
        debugPrint(progress, state)

        switch recognizer.state {
        case .began:
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.popViewController(animated: true)
        case .changed:
            interactivePopTransition?.update(progress)
        case .ended, .cancelled, .failed:
            if progress > 0.5 {
                interactivePopTransition?.finish()
            } else {
                interactivePopTransition?.cancel()
            }
            interactivePopTransition = nil
        default: break
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
