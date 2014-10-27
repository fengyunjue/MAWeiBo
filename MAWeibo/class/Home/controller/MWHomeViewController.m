//
//  MWHemoViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeViewController.h"
#import "UIBarButtonItem+MA.h"
#import "MWTitleButton.h"

@interface MWHomeViewController ()

@end

@implementation MWHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:nil action:nil];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:nil action:nil];
    
    // 中间按钮
    MWTitleButton *titleButton = [[MWTitleButton alloc]init];
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setTitle:@"哈哈哈" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton setFrame:CGRectMake(0, 0, 80, 40)];
    self.navigationItem.titleView = titleButton;
}

- (void)titleClick:(MWTitleButton *)titlebutton
{
    if (titlebutton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_up"]) {
        [titlebutton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }else{
        [titlebutton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
}

@end
