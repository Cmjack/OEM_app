//
//  FiterCollectionViewCell.swift
//  OEM-app
//
//  Created by caiming on 14-6-24.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit

class FiterCollectionViewCell: UICollectionViewCell {

    var photoImageView : UIImageView!

    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        photoImageView = UIImageView(frame:CGRect(x:1,y:1,width:60,height:60))
        photoImageView.image = UIImage(named:"demo@2x.png")
        photoImageView.contentMode = .ScaleAspectFit
        photoImageView.autoresizingMask = .FlexibleWidth | .FlexibleWidth;
        self.addSubview(photoImageView)
    }
    
}
