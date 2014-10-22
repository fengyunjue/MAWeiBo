//
//  MWHemoViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeViewController.h"

@interface MWHomeViewController ()

@end

@implementation MWHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setCenter:CGPointMake(200, 200)];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)click
{
    NSLog(@"地区为地区");
}

@end
