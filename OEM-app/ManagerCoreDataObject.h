//
//  ManagerCoreDataObject.h
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Section.h"
#import "User.h"
@interface ManagerCoreDataObject : NSObject
+(void)addItem:(Item*)item toSection:(Section*)section;
+(void)addSection:(Section*)section toUser:(User*)user;
+(NSArray*)getSectionsFrom:(User*)user;
+(NSArray*)getItemsFrom:(Section*)section;
@end
