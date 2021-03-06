//
//  MWTitleButton.m
//  MAWeibo
//
//  Created by admin on 14-10-26.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWTitleButton.h"

@implementation MWTitleButton

+ (instancetype)titleButton
{
    return [[MWTitleButton alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = MWTitleButtonImageW;
    CGFloat imageY = 0;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width - MWTitleButtonImageW;
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGSize)getSizeWithTitle:(NSString *)title
{
    CGSize size = [title sizeWithFont:self.titleLabel.font];
    size.width += MWTitleButtonImageW + 5;
    return size;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGSize size = [self getSizeWithTitle:title];
    
    CGRect frame = self.frame;
    frame.size.width = size.width;
    self.frame = frame;
//    MALog(@"%@",NSStringFromCGRect(self.frame));
}
@end
