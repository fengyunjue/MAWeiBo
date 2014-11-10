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
#import "MWNavigationController.h"
#import "MWComposeViewController.h"

#import "MWTabBar.h"
#import "MWUserTool.h"
#import "MWAccount.h"
#import "MWUser.h"

@interface MWTabBarViewController ()<MWTabBarDelegate>

@property (weak, nonatomic) MWTabBar *tabBarView;

@property (nonatomic, weak) MWHomeViewController *home;
@property (nonatomic, weak) MWMessageViewController *message;
@property (nonatomic, weak) MWDiscoverViewController *discover;
@property (nonatomic, weak) MWMeViewController *me;

@end

@implementation MWTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1 .初始化tabbar
    [self setupTabbar];
    
    
     [self setupAllChildViewControllers];
    
    // 4. 添加定时器
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

 - (void)checkUnreadCount
{
    MWUserUnreadCountParam *param = [[MWUserUnreadCountParam alloc]init];
    param.uid = @([MWAccount account].uid);
    [MWUserTool userUnreadCountWithParam:param success:^(MWUserUnreadCountResult *result) {
        // 1. home的badge
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        // 2. message的badge
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        // 3. me的badge
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        // 4. 设置图标右上角的数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
        
    } failure:^(NSError *error) {
        
    }];
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
    // 删除tabbar中的所有系统自带子视图
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
/**
 *  代理方法
 */
- (void)tabBar:(MWTabBar *)tabBar didselectButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    if (to == 0) {
        [self.home refresh];
    }
}

- (void)tabBarDidClickPlusButton:(MWTabBar *)tabBar
{
    MWComposeViewController *compuseViewController = [[MWComposeViewController alloc]init];
    MWNavigationController *nav = [[MWNavigationController alloc]initWithRootViewController:compuseViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  初始化TabBar视图
 */
- (void)setupAllChildViewControllers
{
    MWHomeViewController *home = [[MWHomeViewController alloc]init];
    [self setupChildViewController:home title:@"首页" WithImageName:@"tabbar_home" SelectImageName:@"tabbar_home_selected"];
    self.home = home;
    
    MWMessageViewController *message = [[MWMessageViewController alloc]init];
    [self setupChildViewController:message title:@"消息" WithImageName:@"tabbar_message_center" SelectImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    MWDiscoverViewController *discover = [[MWDiscoverViewController alloc]init];
    [self setupChildViewController:discover title:@"广场" WithImageName:@"tabbar_discover"SelectImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    MWMeViewController *me = [[MWMeViewController alloc]init];
    [self setupChildViewController:me title:@"我" WithImageName:@"tabbar_profile" SelectImageName:@"tabbar_profile_selected"];
    self.me = me;
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
    }else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    MWNavigationController *nav = [[MWNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 创建按钮
    [self.tabBarView addTabBarButtonWithItem:childVc.tabBarItem];
}


@end
