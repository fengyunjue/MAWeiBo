//
//  MWUserTool.m
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWUserTool.h"
#import "MWHttpTool.h"
#import "MJExtension.h"

@implementation MWUserTool

+ (void)userInfoWithParam:(MWUserInfoParam *)param success:(void (^)(MWUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [MWHttpTool getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param.keyValues success:^(id json) {
        if (success) {
            // 从数组字典中获取数据模型
            MWUserInfoResult *result = [MWUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
