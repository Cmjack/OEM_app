//
//  ManageCoreData.m
//  impressly
//
//  Created by caiming on 13-12-29.
//  Copyright (c) 2013年 com.impressly. All rights reserved.
//

#import "ManageCoreData.h"

@interface ManageCoreData()
@property(nonatomic, strong)NSString *document;
@property(nonatomic, strong)NSManagedObjectModel *managedObectModel;
@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, strong)NSFetchedResultsController *fetchedResultsController;
@end
@implementation ManageCoreData

+(ManageCoreData*)instance
{
    static ManageCoreData *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ManageCoreData alloc]init];
        
    });
    return manager;
}

-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObectModel !=nil) {
        return _managedObectModel;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"OEM_app" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _managedObectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObectModel;
}

-(NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext!= nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
		[_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        
        
//		[[NSNotificationCenter defaultCenter] addObserver:self
//												 selector:@selector(mergeChangesFromContextDidSaveNotification:)
//													 name:NSManagedObjectContextDidSaveNotification
//												   object:nil];
    }
    return _managedObjectContext;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationCachesDirectory] URLByAppendingPathComponent:@"OEM_app.sqlite"];
    NSLog(@"storeURL:%@",storeURL);
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
      
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		[[NSFileManager defaultManager] removeItemAtURL:[[self applicationCachesDirectory] URLByAppendingPathComponent:@"OEM_app.sqlite"] error:nil];
		[_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}
- (NSURL *)applicationCachesDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}


-(void)saveContext
{
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
           
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (id)fetchData {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];

    NSError *error = nil;
    NSArray *mutableFetchResult = [self.managedObjectContext executeFetchRequest:request error:&error] ;
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    //page = [mutableFetchResult lastObject];
    return mutableFetchResult;
}


@end
