//
//  MWButton.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//


#define MWTabBarButtonImageRatio 0.6
#define MWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor]:[UIColor whiteColor])

#define  MWTabBarButtonTitleSelectedColor (iOS7 ? MWColor(234, 103, 7) : MWColor(248, 139, 0))

#import "MWTabBarButton.h"
#import "MWbadgeButton.h"

@interface MWTabBarButton()

@property (weak, nonatomic) MWbadgeButton *badgeButton;

@end

@implementation MWTabBarButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];

        [self setTitleColor:MWTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:MWTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        if (!iOS7) { // 非iOS7下,设置按钮选中时的背景
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
    
        MWbadgeButton *badgeButton = [[MWbadgeButton alloc]init];
           badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin;
        
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}
/**
 *  设置图片位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = self.frame.size.height * MWTabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH);
}
/**
 *  设置文字位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * MWTabBarButtonImageRatio;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

/**
 *  设置禁止点亮
 */

- (void)setHighlighted:(BOOL)highlighted{}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self.item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [self.item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self.item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [self.item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    self.badgeButton.badgeValue = self.item.badgeValue;
  
    CGRect rect = self.badgeButton.frame;
    rect.origin.x = self.frame.size.width - self.badgeButton.frame.size.width - 8;
    rect.origin.y = 1;
    [self.badgeButton setFrame:rect];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

@end
