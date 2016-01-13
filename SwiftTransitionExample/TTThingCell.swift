//
//  TTThingCell.swift
//  SwiftTransitionExample
//
//  Created by TifaTsubasa on 16/1/13.
//  Copyright © 2016年 TifaTsubasa. All rights reserved.
//

import UIKit

class TTThingCell: UICollectionViewCell {
    
    weak var imgView: UIImageView!
    let titleLabel: UILabel!
    
    var thing: TTThing? {
        didSet {
            imgView.image = thing!.image
            titleLabel.text = thing!.title
        }
    }
    
    override init(frame: CGRect) {
        let imgView = UIImageView()
        self.imgView = imgView
        titleLabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.boldSystemFontOfSize(13)
        super.init(frame: frame)
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imgView.frame = CGRectMake(0, 0, self.bounds.width, self.bounds.width)
        titleLabel.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame), self.bounds.width, self.bounds.height - self.bounds.width)
        super.layoutSubviews()
    }
}
