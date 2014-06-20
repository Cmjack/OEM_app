//
//  Photos.h
//  OEM-app
//
//  Created by caiming on 14-6-19.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class Item;
@interface Photos : UIView
+(void)loadAlbum:(void(^)(id asset))success;
+(UIImage*)thumbnailFrom:(ALAsset*)asset;
+(NSArray*)imagesFromAssets:(NSArray*)assets;

-(void)saveImageToDocmentWithItem:(Item*)item withAsset:(UIImage*)asset;

@end
