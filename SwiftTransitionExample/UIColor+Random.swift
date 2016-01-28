//
//  UIColor+Random.swift
//  SwiftLayer
//
//  Created by TifaTsubasa on 16/1/19.
//  Copyright © 2016年 tifatsubasa. All rights reserved.
//

import UIKit

extension UIColor {
    public class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}