//
//  Photos.m
//  OEM-app
//
//  Created by caiming on 14-6-19.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "Photos.h"
#import <CoreLocation/CoreLocation.h>
#import "Item.h"
@implementation Photos

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });

    return library;
}
+(void)loadAlbum:(void(^)(id asset))success{
    
    __block NSMutableArray * assets = [@[] mutableCopy];
    
    
    __block NSMutableArray* _tmpAssets = [@[] mutableCopy];
    
    ALAssetsLibrary* assetsLib = [Photos defaultAssetsLibrary];
    
    [assetsLib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup* group, BOOL* stop){
        
        [group enumerateAssetsUsingBlock:^(ALAsset* result,NSUInteger index, BOOL *stop) {
            
            if (result) {
                
                [_tmpAssets addObject:result];
            }
        }];
        
        assets = _tmpAssets;
        
        success(assets);
        
        
    } failureBlock:^(NSError* error) {
        
        NSLog(@"[PhotoPicker loadAlbum] error: %@", error);
        
    }];
    

}
+(UIImage*)thumbnailFrom:(ALAsset*)asset
{
    
   return [UIImage imageWithCGImage:[asset thumbnail]];
}

+(NSArray*)imagesFromAssets:(NSArray*)assets
{
    NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:10];
    
    for (ALAsset *asset in assets) {
        id obj = [asset valueForProperty:ALAssetPropertyType];
        if (!obj) {
            continue;
        }
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullScreenImage];
        UIImage *img = [UIImage imageWithCGImage:imgRef
                                           scale:1.0f
                                     orientation:UIImageOrientationUp];
        [returnArray addObject:img];
    }

    return returnArray;
}

-(void)saveImageToDocmentWithItem:(Item*)item withAsset:(UIImage*)asset{
    
    NSData *imageData = UIImageJPEGRepresentation(asset,1.0);
    
    NSString *imagePath = [self writeImageToDocuments:imageData withImageName:item.item_id];
    item.item_url = imagePath;
    NSLog(@"item.item_url:%@",item.item_url);
}
-(NSString*)getDoucmentPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
-(NSString*)writeImageToDocuments:(NSData *)imageData withImageName:(NSString*)fileName
{
    
    NSString *fileNamejpg = [NSString stringWithFormat:@"%@.jpg",fileName];
    NSString *imagePath = [[self getDoucmentPath]stringByAppendingPathComponent:fileNamejpg];
    
    [imageData writeToFile:imagePath atomically:YES];
    
    return imagePath;
}
+(void)deleteImageToDocumentsWithImageName:(NSString*)fileName
{
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
}

@end
