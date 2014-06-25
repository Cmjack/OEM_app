//
//  Fiterimage.m
//  OEM-app
//
//  Created by caiming on 14-6-24.
//  Copyright (c) 2014年 caiming. All rights reserved.
//

#import "Fiterimage.h"
#import "FiterView.h"
@implementation Fiterimage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(UIImage*)imageWithImage:(UIImage*)image index:(NSInteger)index
{
    
    return [FiterView imageWithImage:image withcolorMatrixIndex:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
