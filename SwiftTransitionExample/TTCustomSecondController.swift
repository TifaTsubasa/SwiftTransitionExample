//
//  TTCustomSecondController.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTCustomSecondController: UIViewController, UINavigationControllerDelegate {
    
    var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    var thing: TTThing?
    
    weak var imgView: UIImageView!
    weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = thing?.title
        self.view.backgroundColor = UIColor.white
        
        let imgView = UIImageView()
        imgView.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        imgView.center = CGPoint(x: self.view.bounds.width / 2, y: 200)
        self.view.addSubview(imgView)
        self.imgView = imgView
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: imgView.frame.origin.x, y: imgView.frame.maxY + 15, width: 200, height: 150)
        self.view.addSubview(label)
        self.label = label
        
        imgView.image = thing?.image
        label.text = thing?.overview
        
        let popGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(TTCustomSecondController.handlePopRecognizer(recognizer:)))
        popGesture.edges = .left
        self.view .addGestureRecognizer(popGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let _ = self.navigationController?.delegate {
            self.navigationController?.delegate = nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isEqual(self) && toVC is TTCustomFirstController {
            return TTCustomPopAnimation()
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is TTCustomPopAnimation {
            return interactivePopTransition
        }
        return nil
    }
    
    @objc func handlePopRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = recognizer.translation(in: self.view).x / self.view.bounds.width
        progress = min(1.0, max(0.0, progress))
        
        if recognizer.state == .began {
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        } else if recognizer.state == .changed {
            interactivePopTransition?.update(progress)
        } else if recognizer.state == .ended || recognizer.state == .cancelled {
            if progress > 0.5 {
                interactivePopTransition?.finish()
            } else {
                interactivePopTransition?.cancel()
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
