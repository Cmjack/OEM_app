//
//  MainViewController.swift
//  OEM-app
//
//  Created by caiming on 14-6-18.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit

class MainViewController : UIViewController, UITableViewDelegate, UITableViewDataSource,ChoosePhotoViewControllerDelegate,MainTableViewCellDelegate
{


    var tableView   : UITableView! = nil
    let moc = ManageCoreData.instance().managedObjectContext()
    var user : User! = nil
    var sections : NSArray! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "集匠"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"分享",style : .Plain, target:self, action: "clickShareBtn")

        self.tableView = UITableView(frame:self.view.frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view?.addSubview(self.tableView)
        
        var addBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        addBtn.frame = CGRect(x:CGRectGetMaxX(self.view.bounds)-64, y:CGRectGetMaxY(self.view.bounds)-168, width:44, height:44)
        addBtn.layer.cornerRadius = 22;
        addBtn.layer.masksToBounds = true
        addBtn.addTarget(self, action:"clickAddButton",forControlEvents :.TouchUpInside)
        var image = UIImage(named:"addButton@2x.png")
        addBtn.setImage(image,forState:.Normal)
        self.view.addSubview(addBtn)
        
        var users   =   ManageCoreData.instance().fetchData() as NSArray!
        if users.count == 0
        {
            user = User_Create.userInManagedObjectContext(moc)
        
        }else{
            user = users[0] as User!
        }
        sections = user.sections.allObjects
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        sections = user.sections.allObjects
        self.tableView.reloadData()
        
    }
    
    //#pragma mark - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return sections.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MainTableViewCell!
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.delegate = self
        var section = sections[indexPath.row] as Section
        var items  = section.items.allObjects
        cell.titleLabel.text = section.album_name as String
        cell.deLabel.text = "共\(items.count)张"
        var item : Item! = items[0] as Item
        cell.photoImageView.image = UIImage(contentsOfFile:item.item_url)
        
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
        
        return 70
    
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        var detailViewController = EditPhotosViewController(nibName:nil ,bundle:nil)
        detailViewController.section = sections[indexPath.row] as Section
        self.navigationController.pushViewController(detailViewController, animated:true)
    }
    
    func tableView(tableView: UITableView!, viewForFooterInSection section: Int) -> UIView!
    {
        return UIView()
    }
    
    // #pragma mark - clickBtn
    
    
    func clickAddButton()
    {
        var photosChoose = ChoosePhotoViewController(nibName:nil ,bundle:nil)
        photosChoose.user = user;
        photosChoose.delegate = self;
        self.navigationController.pushViewController(photosChoose, animated:true)

    }
    
    func clickShareBtn(){
    
    
    }
    
    // #pragma mark - ChoosePhotoViewControllerDelegate
    func ChoosePhotoViewControllerCreateSectionSuccess()
    {
//        sections = user.sections.allObjects
//        self.tableView.reloadData()

    }
    
    // #pragma mark - MainTableViewCellDelegate

    func MainTableViewCellTextFieldEndEdit(cell: UITableViewCell!,text :NSString!)
    {
        var indexPath = tableView.indexPathForCell(cell)
        var section = sections[indexPath.row] as Section
        section.album_name = text
        
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
