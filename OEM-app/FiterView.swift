//
//  FiterView.swift
//  OEM-app
//
//  Created by caiming on 14-6-23.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit

class FiterView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{

    var collectionView : UICollectionView!
    var collectionViewLayout : UICollectionViewFlowLayout!
    var items : NSArray!
    var selectIdx : NSInteger!
    var currentImage: UIImage!
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }

    func initSubviews(){
        
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.itemSize = CGSize(width:self.bounds.size.height, height:self.bounds.size.height)
        collectionViewLayout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout:collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pagingEnabled = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(PhotosCollectionViewCell.self, forCellWithReuseIdentifier:"Cell")
        self.addSubview(collectionView)
        items = ["原图","LOMO","黑白","复古","哥特","锐色","淡雅","酒红","青柠","浪漫","光晕","蓝调","梦幻","夜色"]
        
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.items.count
    }
    
    func collectionView(collectionView: UICollectionView?, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell? {
        let cell = collectionView?.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as PhotosCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
       
        cell.photoImageView.image = ImageUtil.changeImage(indexPath.item,imageView:currentImage)

        // Configure the cell
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!){
        var cell  = collectionView.cellForItemAtIndexPath(indexPath) as PhotosCollectionViewCell!
        
    }
    
    func setCurrentImage(image: UIImage!)
    {
        currentImage = image
        
        collectionView.reloadData()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
