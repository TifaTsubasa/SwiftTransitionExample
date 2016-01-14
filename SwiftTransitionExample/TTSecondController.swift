//
//  TTSecondController.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTSecondController: UIViewController, UINavigationControllerDelegate {
    
    var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    var thing: TTThing?
    
    weak var imgView: UIImageView!
    weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = thing?.title
        self.view.backgroundColor = UIColor.whiteColor()
        
        let imgView = UIImageView()
        imgView.bounds = CGRectMake(0, 0, 200, 200)
        imgView.center = CGPointMake(self.view.bounds.width / 2, 200)
        self.view.addSubview(imgView)
        self.imgView = imgView
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.frame = CGRectMake(imgView.frame.origin.x, CGRectGetMaxY(imgView.frame) + 15, 200, 150)
        self.view.addSubview(label)
        self.label = label
        
        imgView.image = thing?.image
        label.text = thing?.overview
        
        let popGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "handlePopRecognizer:")
        popGesture.edges = .Left
        [self.view .addGestureRecognizer(popGesture)]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let _ = self.navigationController?.delegate {
            self.navigationController?.delegate = nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isEqual(self) && toVC is ViewController {
            return TTSecondToFirshAnimation()
        }
        return nil
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is TTSecondToFirshAnimation {
            return interactivePopTransition
        }
        return nil
    }
    
    func handlePopRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = recognizer.translationInView(self.view).x / self.view.bounds.width
        progress = min(1.0, max(0.0, progress))
        
        if recognizer.state == .Began {
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
