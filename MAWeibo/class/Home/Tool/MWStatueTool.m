//
//  MWHomeStatueTool.m
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWStatueTool.h"
#import "MWHttpTool.h"
#import "MJExtension.h"

@implementation MWStatueTool

+ (void)getHomeStatueWithParam:(MWHomeStatueParam *)param success:(void (^)(MWHomeStatueResult *))success failure:(void (^)(NSError *))failure
{
    [MWHttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param.keyValues success:^(id json) {
        if (success) {
            // 从数组字典中获取数据模型
            MWHomeStatueResult *result = [MWHomeStatueResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
         failure(error);
        }

    }];
}

@end
