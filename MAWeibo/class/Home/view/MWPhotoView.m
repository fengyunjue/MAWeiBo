//
//  MWPhotoView.m
//  MAWeibo
//
//  Created by admin on 14-11-1.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWPhotoView.h"
#import "UIImageView+WebCache.h"
#import "MWPhoto.h"
@interface MWPhotoView()
@property (nonatomic ,weak) UIImageView *gifView;
@end
@implementation MWPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:imageView];
        self.gifView = imageView;
    }
    return self;
}


- (void)setPhoto:(MWPhoto *)photo
{
    _photo = photo;
    
    // 控制gifView的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@".gif"];
    
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    //   设置位置在右上角
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
    // 设置位置在右下角
//    self.gifView.layer.anchorPoint = CGPointMake(1, 0);
//    self.gifView.layer.position = CGPointMake(self.frame.size.width, 0);
    
}


@end
