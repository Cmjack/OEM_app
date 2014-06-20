//
//  Section+Create.h
//  OEM-app
//
//  Created by caiming on 14-6-20.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "Section.h"

@interface Section_Create : Section
+(Section*)sectionInManagedObjectContext:(NSManagedObjectContext*)moc;

@end
