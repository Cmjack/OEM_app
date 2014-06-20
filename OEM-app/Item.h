//
//  Item.h
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * item_id;
@property (nonatomic, retain) NSString * item_url;
@property (nonatomic, retain) Section *section;

@end
