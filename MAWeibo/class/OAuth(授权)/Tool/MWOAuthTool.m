//
//  MWOAuthTool.m
//  MAWeibo
//
//  Created by admin on 14-11-5.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWOAuthTool.h"
#import "MWHttpTool.h"
#import "MJExtension.h"

@implementation MWOAuthTool

+ (void)OAuthWithParam:(MWOAuthParam *)param success:(void (^)(MWOAuthResult *))success failure:(void (^)(NSError *))failure
{
    [MWHttpTool postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param.keyValues success:^(id json) {
        if (success) {
            MWOAuthResult *result = [MWOAuthResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
