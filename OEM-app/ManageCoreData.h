//
//  ManageCoreData.h
//  impressly
//
//  Created by caiming on 13-12-29.
//  Copyright (c) 2013年 com.impressly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ManageCoreData : NSObject
+(ManageCoreData*)instance;
-(void)saveContext;
-(NSManagedObjectModel *)managedObjectModel;
-(NSManagedObjectContext *)managedObjectContext;
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (id)fetchData;
@end
