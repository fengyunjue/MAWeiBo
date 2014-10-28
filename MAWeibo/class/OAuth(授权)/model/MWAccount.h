//
//  MWAccount.h
//  MAWeibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 mage. All rights reserved.
//  账号模型
//

#import <Foundation/Foundation.h>

@interface MWAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;
//初始化信息时
+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

// 存储用户账号信息
+ (void)saveAccount:(MWAccount *)account;
// 获取用户账号信息
+ (MWAccount *)account;

@end

