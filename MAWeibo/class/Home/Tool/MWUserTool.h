//
//  MWUserTool.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWUserInfoParam.h"
#import "MWUserInfoResult.h"

#import "MWUserUnreadCountParam.h"
#import "MWUserUnreadCountResult.h"

@interface MWUserTool : NSObject
/**
 *  获取用户数据
 *
 *  @param param   请求参数
 *  @param success 请求成功回调结果
 *  @param failure 请求失败回调结果
 */
+ (void)userInfoWithParam:(MWUserInfoParam *)param success:(void (^)(MWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  获取某个用户的各种消息未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功回调结果
 *  @param failure 请求失败回调结果
 */
+ (void)userUnreadCountWithParam:(MWUserUnreadCountParam *)param success:(void (^)(MWUserUnreadCountResult *))success failure:(void (^)(NSError *))failure;
@end
