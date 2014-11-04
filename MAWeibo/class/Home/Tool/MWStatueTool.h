//
//  MWHomeStatueTool.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
// 微博业务处理类（工具类）


#import <Foundation/Foundation.h>
#import "MWHomeStatueParam.h"
#import "MWHomeStatueResult.h"

@interface MWStatueTool : NSObject
/**
 *  获取微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功回调结果
 *  @param failure 请求失败回调结果
 */
+ (void)getHomeStatueWithParam:(MWHomeStatueParam *)param success:(void (^)(MWHomeStatueResult *result))success failure:(void (^)(NSError *error))failure;

@end
