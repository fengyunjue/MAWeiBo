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
#import "MWStatueCacheTool.h"
#import "MWStatuse.h"

@implementation MWStatueTool

+ (void)getHomeStatueWithParam:(MWHomeStatueParam *)param success:(void (^)(MWHomeStatueResult *result))success failure:(void (^)(NSError *error))failure
{
    NSArray *dictArray = [MWStatueCacheTool getStatuesWithParam:param];
    if (dictArray.count) {
        MWHomeStatueResult *result = [[MWHomeStatueResult alloc]init];
        result.statuses = [MWStatuse objectArrayWithKeyValuesArray:dictArray];
        if (success) {
            success(result);
        }
    }else{
    [MWHttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param.keyValues success:^(id json) {
        [MWStatueCacheTool saveStatueWithArray:json[@"statuses"]];
            // 从数组字典中获取数据模型
            MWHomeStatueResult *result = [MWHomeStatueResult objectWithKeyValues:json];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
         failure(error);
        }

    }];
    }
}

@end
