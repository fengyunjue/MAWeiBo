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
// 选中的按钮
@property (weak, nonatomic) MWTabBarButton *selectButton;

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@end
@implementation MWTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizedImageWithName:@"tabbar_background"]];
        }
        
        UIButton *plusButton = [[UIButton alloc]init];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setFrame:CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height)];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        
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
    
    [self.tabBarButtons addObject:button];
    if (self.tabBarButtons.count == 1) {
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
    CGFloat w = self.frame.size.width;
    CGFloat h =self.frame.size.height;
    [self.plusButton setCenter:CGPointMake(w * 0.5, h * 0.5)];
    
    // 按钮的Frame
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (NSInteger index = 0; index < self.tabBarButtons.count; index++) {
        // 1. 取出按钮
        MWTabBarButton *button = self.tabBarButtons[index];
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        // 2. 设置按钮的frame
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3. 绑定tag
        button.tag = index;
        
    }
}

@end
