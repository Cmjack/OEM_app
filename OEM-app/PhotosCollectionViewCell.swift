//
//  PhotosCollectionViewCell.swift
//  OEM-app
//
//  Created by caiming on 14-6-17.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit


protocol PhotosCollectionViewCellDelegate : NSObjectProtocol {
    
    func PhotosCollectionViewLongPressCell(cell:UICollectionViewCell)
}
class PhotosCollectionViewCell: UICollectionViewCell {

    var photoImageView : UIImageView!
    var chooseImageView :UIImageView!
    var delegate : PhotosCollectionViewCellDelegate!
    var longPress : UILongPressGestureRecognizer!
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        photoImageView = UIImageView(frame: self.bounds)
        photoImageView.image = UIImage(named:"demo@2x.png")
        photoImageView.contentMode = .ScaleAspectFit
        photoImageView.autoresizingMask = .FlexibleWidth | .FlexibleWidth;

        self.addSubview(photoImageView)
        
        chooseImageView = UIImageView(frame: self.bounds)
        chooseImageView.image = UIImage(named:"choose@2x.png")
        chooseImageView.contentMode = .ScaleAspectFit
        chooseImageView.hidden = true

        self.addSubview(chooseImageView)
//        func addTarget(target: AnyObject!, action: Selector)
        
        longPress = UILongPressGestureRecognizer(target:self, action:"longPressView")
        self.addGestureRecognizer(longPress)
        
    }
    
    func longPressView(){
        
        if longPress.state == .Began
        {
            self.delegate?.PhotosCollectionViewLongPressCell(self)

        }
        
    
    }
    
    
}
