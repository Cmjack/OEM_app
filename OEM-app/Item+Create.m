//
//  Item+Create.m
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "Item+Create.h"

@implementation Item_Create
+(Item*)itemInManagedObjectContext:(NSManagedObjectContext*)moc {
    Item* obj = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc];
    obj.item_id = [[NSUUID UUID]UUIDString];
    return obj;
}
@end
