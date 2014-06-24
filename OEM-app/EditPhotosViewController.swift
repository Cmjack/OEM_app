//
//  EditPhotosViewController.swift
//  OEM-app
//
//  Created by caiming on 14-6-18.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit

class EditPhotosViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,EditImageViewDelegate,PhotosCollectionViewCellDelegate,UIActionSheetDelegate,ChoosePhotoViewControllerDelegate{

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    var section : Section! = nil
    var collectionView : UICollectionView!
    var collectionViewLayout : CHTCollectionViewWaterfallLayout!
    
    var items : NSArray! = []
    var edit : EditImageView!
    var rect : CGRect!
    var deleteIndexPath : NSIndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"添加",style : .Plain, target:self, action: "clickAddButton")
        self.title = section.album_name
       
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
        cell.photoImageView.image = UIImage(contentsOfFile:(items[indexPath.item] as Item).item_url)
        cell.photoImageView.frame = cell.bounds
        cell.delegate = self
        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView:UICollectionView?,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize{
        var image = UIImage(contentsOfFile:(items[indexPath.item] as Item).item_url)
        var size = image.size
        return (CGSizeMake(144, 144 * size.height/size.width))
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!){
        var cell  = collectionView.cellForItemAtIndexPath(indexPath) as PhotosCollectionViewCell!
        
        var image = UIImage(contentsOfFile:(items[indexPath.item] as Item).item_url)
        rect = self.view.convertRect(cell.frame,fromView:self.collectionView)
        edit = EditImageView(frame:rect)
        edit.delegate = self
        edit.items = items
        edit.selectIdx = indexPath.row
        edit.initSubviews()
        self.view.addSubview(edit)
        
        UIView.animateWithDuration(0.25, animations:{
            
            self.navigationController.navigationBarHidden = true

            self.edit.frame = self.view.bounds
            
            },completion:{ mBool in
                self.edit.collectionView.hidden = false
                self.edit.imageView.hidden = true
                
            })
        
        
    }

    func EditImageViewSuccess()
    {
        UIView.animateWithDuration(0.25, animations:{
            
            self.navigationController.navigationBarHidden = false
            
            self.edit.alpha = 0
            
            },completion:{ mBool in
             
             self.edit.removeFromSuperview()
             self.edit = nil
                
            })
    }
    
    func PhotosCollectionViewLongPressCell(cell:UICollectionViewCell)
    {
        
        deleteIndexPath = collectionView.indexPathForCell(cell)
        var sheet  =  UIActionSheet()
        sheet.delegate = self
        sheet.addButtonWithTitle("删除")
        sheet.addButtonWithTitle("取消")
        sheet.cancelButtonIndex = 1
        sheet.destructiveButtonIndex = 0
        sheet.showInView(self.view)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex == 0
        {
            section.removeItemsObject(items[deleteIndexPath.item] as Item)
            items = section.items.allObjects
            self.collectionView.deleteItemsAtIndexPaths([deleteIndexPath])
        }
        
    }
    
    func clickAddButton(){
        
        var photosChoose = ChoosePhotoViewController(nibName:nil ,bundle:nil)
        photosChoose.delegate = self;
        photosChoose.section = section
        self.navigationController.pushViewController(photosChoose, animated:true)

    
    }
    
    func ChoosePhotoViewControllerCreateSectionSuccess()
    {
        items = section.items.allObjects
        self.collectionView.reloadData()
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
