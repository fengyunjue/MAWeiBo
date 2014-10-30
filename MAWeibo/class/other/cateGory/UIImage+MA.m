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
    if (image) {
        return image;
    }
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizedImageWithName:(NSString *)name withleft:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name withleft:0.5 top:0.5];
}

@end
