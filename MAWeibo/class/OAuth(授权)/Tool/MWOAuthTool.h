//
//  MWOAuthTool.h
//  MAWeibo
//
//  Created by admin on 14-11-5.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWOAuthParam.h"
#import "MWOAuthResult.h"

@interface MWOAuthTool : NSObject
/**
 *  OAuth授权
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调结果
 *  @param failure 请求失败后的回调结果
 */
+ (void)OAuthWithParam:(MWOAuthParam *)param success:(void (^)(MWOAuthResult *result))success failure:(void (^)(NSError *error))failure;

@end
