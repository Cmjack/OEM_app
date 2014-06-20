//
//  EditPhotosViewController.swift
//  OEM-app
//
//  Created by caiming on 14-6-18.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit

class EditPhotosViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    var section : Section! = nil
    var collectionView : UICollectionView!
    var collectionViewLayout : CHTCollectionViewWaterfallLayout!
    
    var items : NSArray! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout = CHTCollectionViewWaterfallLayout()
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionViewLayout.minimumColumnSpacing = 12
        collectionViewLayout.columnCount = 2
        
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout:collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(PhotosCollectionViewCell.self, forCellWithReuseIdentifier:"Cell")

        self.view.addSubview(collectionView)
        // Do any additional setup after loading the view.
//        let fruits : AnyObject[] = Photos.loadAlbum()
//        class func animateWithDuration(duration: NSTimeInterval, animations: (() -> Void)!, completion: ((Bool) -> Void)!) // delay = 0.0, options = 0
        
        items = section.items.allObjects
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
     func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return items.count
    }
    
     func collectionView(collectionView: UICollectionView?, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell? {
        let cell = collectionView?.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as PhotosCollectionViewCell
        
        var item : Item! = items[indexPath.row] as Item
        cell.photoImageView.image = UIImage(contentsOfFile:item.item_url)
        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView:UICollectionView?,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize{
    
        var item : Item! = items[indexPath.row] as Item

        var image = UIImage(contentsOfFile:item.item_url)
        var size = image.size
        return (CGSizeMake(144, 144 * size.height/size.width))

        
        
//        if size.width/size.height>144/192
//        {
//            println(CGSizeMake(144, 144 * size.height/size.width))
//            
//            return (CGSizeMake(144, 144 * size.height/size.width))
//
//            
//        }else
//        {
////            return CGSizeMake(144, size.width/144*size.height)
//
//        }
//        
//        return CGSizeMake(144, 192)
    
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
