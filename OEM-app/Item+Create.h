//
//  Item+Create.h
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "Item.h"

@interface Item_Create : Item
+(Item*)itemInManagedObjectContext:(NSManagedObjectContext*)moc;
@end
