//
//  Section.h
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, User;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * album_name;
@property (nonatomic, retain) NSString * photo_id;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) User *user;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
