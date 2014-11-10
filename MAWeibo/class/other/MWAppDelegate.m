//
//  MWAppDelegate.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWAppDelegate.h"
#import "MWWeiboTool.h"
#import "SDWebImageManager.h"

@implementation MWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.rootViewController = [MWWeiboTool MWWeiboToolDecideLogin];
   
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
/**
 让程序保持后台运行
 1.尽量申请后台运行的时间
 [application beginBackgroundTaskWithExpirationHandler:^{
 
 }];
 
 2.在Info.plist中声明自己的应用类型为audio、在后台播放mp3
 */

/**
 *  app进入后台会调用这个方法
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    MALog(@"进入后台");
    [application beginBackgroundTaskWithExpirationHandler:^{
        MALog(@"过期了---");
    }];
    // 定时提醒（定时弹框）
//    [UILocalNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 *  内存警告时调用
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
