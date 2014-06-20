//
//  Section+Create.m
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "Section+Create.h"

@implementation Section_Create

+(Section*)sectionInManagedObjectContext:(NSManagedObjectContext*)moc {
    Section* obj = [NSEntityDescription insertNewObjectForEntityForName:@"Section" inManagedObjectContext:moc];
    obj.photo_id = [[NSUUID UUID]UUIDString];
    return obj;
}
@end
