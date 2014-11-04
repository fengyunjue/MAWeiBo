//
//  MWComposePhotoView.h
//  MAWeibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MWComposePhotoView;
@protocol MWComposePhotoViewDelegate <NSObject>
@optional

- (void)composePhotoViewAddButton:(MWComposePhotoView *)toolBar;
- (void)composePhotoViewDeleteButton:(MWComposePhotoView *)toolBar;

@end

@interface MWComposePhotoView : UIView

@property (nonatomic, strong, readonly) NSArray *images;

@property (nonatomic ,weak) id<MWComposePhotoViewDelegate> degelate;
/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image;

@end
