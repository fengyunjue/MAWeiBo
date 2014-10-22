//
//  UIImage+UIimage_MA.h
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MA)

/**
 *  用于设置图片同时适配IOS6与IOS7
 *
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)imageWithName:(NSString *)name;

@end

