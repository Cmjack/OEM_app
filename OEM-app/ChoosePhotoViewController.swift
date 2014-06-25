//
//  ChoosePhotoViewController.swift
//  OEM-app
//
//  Created by caiming on 14-6-19.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit
import AssetsLibrary

protocol ChoosePhotoViewControllerDelegate : NSObjectProtocol {
    
    func ChoosePhotoViewControllerCreateSectionSuccess()
}
class ChoosePhotoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate  {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    var delegate : ChoosePhotoViewControllerDelegate!
    var collectionView : UICollectionView!
    var collectionViewLayout : UICollectionViewFlowLayout!
    
    var assets : ALAsset[] = []
    var selectAssets : NSMutableArray = []
    var chooseIndexPaths : NSMutableArray = []
    
    var alertView : UIAlertView!
    var user : User!
    var section :  Section!
    let moc = ManageCoreData.instance().managedObjectContext()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "相册"
                // Do any additional setup after loading the view.
        Photos.loadAlbum{ sites in
            
            self.assets = sites as ALAsset[]
            self.collectionView.reloadData()
        }
        if user != nil
        {
            section = Section_Create.sectionInManagedObjectContext(moc)

        }
        
        self.initSubViews()
    }
    func initSubViews(){
    
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionViewLayout.minimumLineSpacing = 12
        collectionViewLayout.itemSize = CGSizeMake(92, 92)

        
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout:collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(PhotosCollectionViewCell.self, forCellWithReuseIdentifier:"Cell")
        self.view.addSubview(collectionView)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"保存",style : .Plain, target:self, action: "clickDoneButton")
        self.navigationItem.rightBarButtonItem.enabled = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func clickDoneButton(){
        
        if user != nil
        {
            self.alertView = UIAlertView()
            self.alertView.delegate = self
            self.alertView.message = "主人赐个名字吧"
            self.alertView.addButtonWithTitle("取消")
            self.alertView.addButtonWithTitle("确定")
            self.alertView.alertViewStyle = .PlainTextInput
            self.alertView.show()

        }else
        {
            createItems()
            self.navigationController.popViewControllerAnimated(true)
            self.delegate?.ChoosePhotoViewControllerCreateSectionSuccess()
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.assets.count
    }
    
    func collectionView(collectionView: UICollectionView?, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell? {
        let cell = collectionView?.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as PhotosCollectionViewCell
         let  asset = self.assets[indexPath.item];
        cell.photoImageView.image = Photos.thumbnailFrom(asset)
        
        if chooseIndexPaths.containsObject(indexPath){
            
            cell.chooseImageView.hidden = false
            
        }else
        {
            cell.chooseImageView.hidden = true
        }
        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView:UICollectionView?,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize{
        
        return CGSizeMake(92, 92);
    }

    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!){
        var cell  = collectionView.cellForItemAtIndexPath(indexPath) as PhotosCollectionViewCell!
        var  asset = self.assets[indexPath.item];

        
        if chooseIndexPaths.containsObject(indexPath){
            
            chooseIndexPaths.removeObject(indexPath)
            selectAssets.removeObject(asset)
            cell.chooseImageView.hidden = true
            
        }else
        {
            chooseIndexPaths.addObject(indexPath)
            selectAssets.addObject(asset)
            cell.chooseImageView.hidden = false
        }
        if selectAssets.count > 0
        {
            self.navigationItem.rightBarButtonItem.enabled = true

        }else
        {
            self.navigationItem.rightBarButtonItem.enabled = false

        }
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        var textField = alertView.textFieldAtIndex(0) as UITextField!
        
        if buttonIndex == 1 {
        
           section.album_name = textField.text
           self.createItems()
            user.addSectionsObject(section)

           self.navigationController.popViewControllerAnimated(true)
           self.delegate?.ChoosePhotoViewControllerCreateSectionSuccess()
           
        }
        
        
    }
    
    func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView!) -> Bool
    {
        var textField = alertView.textFieldAtIndex(0) as UITextField!
        if textField.text {
            
          return true
        }
        return false
    }
    
    func createItems()
    {
        var images : AnyObject[] = Photos.imagesFromAssets(selectAssets)
        for image : AnyObject in images{
            var item : Item! = Item_Create.itemInManagedObjectContext(moc)
            section.addItemsObject(item)
            Photos().saveImageToDocmentWithItem(item, withAsset : image as UIImage)
        }
        
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
