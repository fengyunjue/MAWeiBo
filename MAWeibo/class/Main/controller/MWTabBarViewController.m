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

@interface MWTabBarViewController ()<MWTabBarDelegate>

@property (weak, nonatomic) MWTabBar *tabBarView;

@end

@implementation MWTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    
    
     [self setupAllChildViewControllers];
    
  

}
/**
 *  初始化所有子控制器
 */
- (void)setupTabbar
{
    MWTabBar *tabBarView = [[MWTabBar alloc]init];
    [tabBarView setFrame:self.tabBar.bounds];
    [self.tabBar addSubview:tabBarView];
    tabBarView.delegate = self;
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
 *  代理方法
 */
- (void)tabBar:(MWTabBar *)tabBar didselectButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

/**
 *  初始化TabBar视图
 */
- (void)setupAllChildViewControllers
{
    MWHomeViewController *home = [[MWHomeViewController alloc]init];
    home.tabBarItem.badgeValue = @"100";
    
    [self setupChildViewController:home title:@"首页" WithImageName:@"tabbar_home" SelectImageName:@"tabbar_home_selected"];
    
    MWMessageViewController *message = [[MWMessageViewController alloc]init];
     message.tabBarItem.badgeValue = @"100";
    [self setupChildViewController:message title:@"消息" WithImageName:@"tabbar_message_center" SelectImageName:@"tabbar_message_center_selected"];
    
    MWDiscoverViewController *discover = [[MWDiscoverViewController alloc]init];
     discover.tabBarItem.badgeValue = @"100";
    [self setupChildViewController:discover title:@"广场" WithImageName:@"tabbar_discover"SelectImageName:@"tabbar_discover_selected"];

    
    MWMeViewController *me = [[MWMeViewController alloc]init];
     me.tabBarItem.badgeValue = @"100";
    [self setupChildViewController:me title:@"我" WithImageName:@"tabbar_profile" SelectImageName:@"tabbar_profile_selected"];
 
}

/**
 *  初始化一个自控制器
 *
 *  @param childVc     需要初始化的子控制器
 *  @param title       标题
 *  @param image       图标
 *  @param selectImage 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title WithImageName:(NSString *)imageName SelectImageName:(NSString *)selectImageName
{
    // 1. 设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中图片
    UIImage *selectedImage = [UIImage imageWithName:selectImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 创建按钮
    [self.tabBarView addTabBarButtonWithItem:childVc.tabBarItem];
}


@end
