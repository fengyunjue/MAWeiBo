//
//  MWTextField.m
//  MAWeibo
//
//  Created by admin on 14-10-25.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWSearchBar.h"

@implementation MWSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认大小
        self.frame = CGRectMake(0, 0, 300, 30);
        // 设置背景图片
        [self setBackground:[UIImage resizedImageWithName:@"searchbar_textfield_background"]];
        // 左边放大镜图标
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        [iconView setFrame:CGRectMake(0, 0, 30, 30)];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        // 设置清除图标
        self.clearButtonMode = UITextFieldViewModeAlways;
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        // 设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        
        self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:attrs];
        if (iOS7) {
            
        }
        // 设置键盘右下角的按钮样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}


@end
