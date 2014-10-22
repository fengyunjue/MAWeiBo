//
//  MWTabBar.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWTabBar.h"
#import "MWTabBarButton.h"

@interface MWTabBar()

@property (weak, nonatomic) MWTabBarButton *selectButton;

@end
@implementation MWTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizedImageWithName:@"tabbar_background"]];
        }
    }
    return self;
}

/**
 *  创建按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    MWTabBarButton *button = [[MWTabBarButton alloc]init];
    button.item = item;
    [self addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    
    
    if (self.subviews.count == 1) {
        [self click:button];
    }
    
}


- (void)click:(MWTabBarButton *)button
{
    // 1. 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didselectButtonFrom:to:)]) {
        [self.delegate tabBar:self didselectButtonFrom:self.selectButton.tag to:button.tag];
    }
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮的Frame
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (NSInteger index = 0; index < self.subviews.count; index++) {
        // 1. 取出按钮
        MWTabBarButton *button = self.subviews[index];
        
        // 2. 设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3. 绑定tag
        button.tag = index;
        
    }
}

@end
