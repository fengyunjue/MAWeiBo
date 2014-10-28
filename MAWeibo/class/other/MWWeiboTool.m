//
//  MWWeiboTool.m
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWWeiboTool.h"
#import "MWOAuthViewController.h"
#import "MWTabBarViewController.h"
#import "MWNewFeatureViewController.h"
#import "MWAccount.h"

@implementation MWWeiboTool


+ (UIViewController *)MWWeiboToolDecideNewVersions
{
    NSString *key = @"CFBundleVersion";
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    UIViewController *viewController = nil;
    
        // 判断使用哪个控制器
        if ([lastVersion isEqualToString:currentVersion]) {
            [UIApplication sharedApplication].statusBarHidden = NO;
            viewController = [[MWTabBarViewController alloc]init];
        }else{
            // 新版本
           viewController = [[MWNewFeatureViewController alloc]init];
            // 储存新版本
            [defaults setObject:currentVersion forKey:key];
            // 数据即时写入
            [defaults synchronize];
        }

    return viewController;
    
}
/**
 *  判断用户是否登录
 *
 *  @return 登录了,判断是否为新版本,登录了,返回登录页
 */
+ (UIViewController *)MWWeiboToolDecideLogin
{
    UIViewController *viewController = nil;
    
    MWAccount *account = [MWAccount account];
    if (account != nil) {
       viewController = [MWWeiboTool MWWeiboToolDecideNewVersions];
    }else{
        viewController = [[MWOAuthViewController alloc]init];
    }
    return viewController;
}

@end
