//
//  ManagerCoreDataObject.m
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "ManagerCoreDataObject.h"

@implementation ManagerCoreDataObject

+(void)addItem:(Item*)item toSection:(Section*)section
{
    [section addItemsObject:item];
}
+(void)addSection:(Section *)section toUser:(User *)user
{
    [user addSectionsObject:section];
    
}
+(NSArray*)getSectionsFrom:(User*)user
{
    return [user.sections allObjects];
}
+(NSArray*)getItemsFrom:(Section*)section
{
    return [section.items allObjects];
}
@end
