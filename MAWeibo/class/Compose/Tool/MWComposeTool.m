//
//  MWCompuseTool.m
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWComposeTool.h"
#import "MWHttpTool.h"
#import "MJExtension.h"


@implementation MWComposeTool

+ (void)composeWithoutImageWithParam:(MWComposeParam *)param success:(void (^)(MWComposeResult *result))success failure:(void (^)(NSError *error))failure
{
    [MWHttpTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param.keyValues success:^(id json) {
        
        if (success) {
            MWComposeResult *result = [MWComposeResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (success) {
            failure(error);
        }
    }];
}

+ (void)composeWithImageWithParam:(MWComposeParam *)param dataArray:(NSArray *)dataArray success:(void (^)(MWComposeResult *result))success failure:(void (^)(NSError *error))failure
{
    
    [MWHttpTool postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" param:param.keyValues dataArray:dataArray success:^(id json) {
        if (success) {
            MWComposeResult *result = [MWComposeResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (success) {
            failure(error);
        }
    }];
}

@end
