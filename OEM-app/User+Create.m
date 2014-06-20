//
//  User+Create.m
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "User+Create.h"

@implementation User_Create
+(User*)userInManagedObjectContext:(NSManagedObjectContext*)moc {
    User* user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
    user.username = @"123";
    return user;
}
@end
