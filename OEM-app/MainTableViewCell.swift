//
//  MainTableViewCell.swift
//  OEM-app
//
//  Created by caiming on 14-6-17.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

     var photoImageView : UIImageView!
     var maskImageView  : UIImageView!
     var titleLabel     : UILabel!
     var deLabel        : UILabel!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        self.initSubViews()
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
                // Initialization code
    }
    
    func initSubViews(){

        photoImageView = UIImageView(frame:CGRect(x:28,y:9,width:50,height:50))
        photoImageView.image = UIImage(named:"demo")
        self.addSubview(photoImageView)
        
        maskImageView = UIImageView(frame:CGRect(x:20,y:3,width:65,height:64))
        maskImageView.image = UIImage(named:"folderFrame")
        self.addSubview(maskImageView)
        
        titleLabel = UILabel(frame:CGRect(x:99,y:9,width:247,height:21))
        titleLabel.font = UIFont.systemFontOfSize(17)
        titleLabel.text = "我的相册"
        self.addSubview(titleLabel)
        
        deLabel = UILabel(frame:CGRect(x:99,y:38,width:247,height:21))
        deLabel.font = UIFont.systemFontOfSize(15)
        deLabel.text = "共5张"

        self.addSubview(deLabel)
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
