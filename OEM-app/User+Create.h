//
//  User+Create.h
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "User.h"

@interface User_Create : User
+(User*)userInManagedObjectContext:(NSManagedObjectContext*)moc;

@end
