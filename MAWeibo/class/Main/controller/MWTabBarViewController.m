//
//  MWViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWTabBarViewController.h"
#import "MWHomeViewController.h"
#import "MWMessageViewController.h"
#import "MWMeViewController.h"
#import "MWDiscoverViewController.h"

#import "MWTabBar.h"

@interface MWTabBarViewController ()

@property (weak, nonatomic) MWTabBar *tabBarView;

@end

@implementation MWTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self setupAllChildViewControllers];
    
    // 初始化tabbar
    [self setupTabbar];
    
   
    
}
/**
 *  初始化所有子控制器
 */
- (void)setupAllChildViewControllers
{
    MWTabBar *tabBarView = [[MWTabBar alloc]init];
    [tabBarView setFrame:self.tabBar.bounds];
    [self.tabBar addSubview:tabBarView];
    
    self.tabBarView = tabBarView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除tabbar中的所有子视图
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化TabBar视图
 */
- (void)setupTabbar
{
    MWHomeViewController *home = [[MWHomeViewController alloc]init];
    [self setupChildViewController:home title:@"首页" WithImage:[UIImage imageWithName:@"tabbar_home"] SelectImage:[UIImage imageWithName:@"tabbar_home_selected"]];
    
    MWMessageViewController *message = [[MWMessageViewController alloc]init];
    [self setupChildViewController:message title:@"消息" WithImage:[UIImage imageWithName:@"tabbar_message_center"] SelectImage:[UIImage imageWithName:@"tabbar_message_center_selected"]];
    
    MWDiscoverViewController *discover = [[MWDiscoverViewController alloc]init];
    [self setupChildViewController:discover title:@"广场" WithImage:[UIImage imageWithName:@"tabbar_discover"] SelectImage:[UIImage imageWithName:@"tabbar_discover_selected"]];

    
    MWMeViewController *me = [[MWMeViewController alloc]init];
    [self setupChildViewController:me title:@"我" WithImage:[UIImage imageWithName:@"tabbar_profile"] SelectImage:[UIImage imageWithName:@"tabbar_profile_selected"]];
 
}

/**
 *  初始化一个自控制器
 *
 *  @param childVc     需要初始化的子控制器
 *  @param title       标题
 *  @param image       图标
 *  @param selectImage 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title WithImage:(UIImage *)image SelectImage:(UIImage *)selectImage
{
    // 1. 设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = image;
    // 设置选中图片
    childVc.tabBarItem.selectedImage = selectImage;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 创建按钮
    [self.tabBarView addTabBarButtonWithItem:childVc.tabBarItem];
}


@end
