//
//  MWWeiboTool.h
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWWeiboTool : NSObject

// 判断用户是否登录
+ (UIViewController *)MWWeiboToolDecideLogin;
// 判断是否显示新特性
+ (UIViewController *)MWWeiboToolDecideNewVersions;

@end
