//
//  UIImage+UIimage_MA.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "UIImage+MA.h"

@implementation UIImage (MA)



+ (UIImage *)imageWithName:(NSString *)name
{
    NSString *imageName = name;
    if (iOS7) {
        imageName = [NSString stringWithFormat:@"%@_os7",name];
    }
    UIImage *image = [UIImage imageNamed:imageName];
    
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
