//
//  TTScaleSecondController.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/26.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTScaleSecondController: UIViewController {

    @IBAction func pop(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
