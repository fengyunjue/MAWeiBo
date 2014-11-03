//
//  MWToolBar.m
//  MAWeibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWComposeToolBar.h"

@implementation MWComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        [self addButtonWithIcon:@"compose_camerabutton_background" HighlightedImageName:@"compose_camerabutton_background_highlighted" tag:MWComposeToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" HighlightedImageName:@"compose_toolbar_picture_highlighted" tag:MWComposeToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_Mentionbutton_background" HighlightedImageName:@"compose_Mentionbutton_background_highlighted" tag:MWComposeToolBarButtonTypeMention];
        [self addButtonWithIcon:@"compose_Trendbutton_background" HighlightedImageName:@"compose_Trendbutton_background_highlighted" tag:MWComposeToolBarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" HighlightedImageName:@"compose_emoticonbutton_background_highlighted" tag:MWComposeToolBarButtonTypeEmotion];
    }
    return self;
}

- (void)addButtonWithIcon:(NSString *)icon HighlightedImageName:(NSString *)HighlightedImageName tag:(MWComposeToolBarButtonType)type
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:HighlightedImageName] forState:UIControlStateHighlighted];
    btn.tag = type;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:ButtonType:)]) {
        [self.delegate composeToolBar:self ButtonType:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
