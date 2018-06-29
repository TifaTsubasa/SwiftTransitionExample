//
//  TTScaleFirstController.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/26.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTScaleFirstController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = true
    }

}
