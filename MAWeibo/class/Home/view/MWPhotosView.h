//
//  MWPhotos.h
//  MAWeibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 mage. All rights reserved.
//  九宫格图片视图
//

#import <UIKit/UIKit.h>

@interface MWPhotosView : UIView
/**
 *  里面放的是MWPhoto的模型
 */
@property (nonatomic, strong) NSArray *photos;

+ (CGSize)MWPhotosViewRectWithImageCount:(NSInteger)count;

@end
